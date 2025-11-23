use std::sync::{Mutex, Condvar};

struct H2O {
    state: Mutex<(usize, usize)>, // (h_count, o_count) - counts of atoms waiting for the current molecule
    cond: Condvar,
}

impl H2O {
    fn new() -> Self {
        H2O {
            state: Mutex::new((0, 0)),
            cond: Condvar::new(),
        }
    }

    fn hydrogen(&self, releaseHydrogen: impl FnOnce()) {
        let mut guard = self.state.lock().unwrap();
        loop {
            if guard.0 < 2 { // There's room for another H atom in the current molecule
                guard.0 += 1;
                if guard.0 == 2 && guard.1 == 1 { // This H atom completes a molecule
                    releaseHydrogen();
                    guard.0 = 0; // Reset counts for the next molecule
                    guard.1 = 0;
                    self.cond.notify_all(); // Wake up the other 2 threads (1st H, 1 O)
                    break;
                } else { // Molecule not yet complete, wait for others
                    guard = self.cond.wait(guard).unwrap();
                    // After waking up, check if we were part of the just-formed molecule
                    if guard.0 == 0 && guard.1 == 0 {
                        releaseHydrogen();
                        break;
                    }
                    // If not (e.g., spurious wakeup, or another H atom was reset), loop and re-evaluate
                }
            } else { // Two H atoms are already waiting/processed for the current molecule. Wait for a new molecule cycle.
                guard = self.cond.wait(guard).unwrap();
            }
        }
    }

    fn oxygen(&self, releaseOxygen: impl FnOnce()) {
        let mut guard = self.state.lock().unwrap();
        loop {
            if guard.1 < 1 { // There's room for an O atom in the current molecule
                guard.1 += 1;
                if guard.0 == 2 && guard.1 == 1 { // This O atom completes a molecule
                    releaseOxygen();
                    guard.0 = 0; // Reset counts for the next molecule
                    guard.1 = 0;
                    self.cond.notify_all(); // Wake up the 2 H atoms
                    break;
                } else { // Molecule not yet complete, wait for others
                    guard = self.cond.wait(guard).unwrap();
                    // After waking up, check if we were part of the just-formed molecule
                    if guard.0 == 0 && guard.1 == 0 {
                        releaseOxygen();
                        break;
                    }
                    // If not (e.g., spurious wakeup), loop and re-evaluate
                }
            } else { // One O atom is already waiting/processed for the current molecule. Wait for a new molecule cycle.
                guard = self.cond.wait(guard).unwrap();
            }
        }
    }
}