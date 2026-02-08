use std::sync::{Arc, Mutex};
use std::thread;

struct DiningPhilosophers {
    forks: Vec<Arc<Mutex<()>>>,
}

impl DiningPhilosophers {
    fn new() -> Self {
        let forks = (0..5).map(|_| Arc::new(Mutex::new(()))).collect();
        DiningPhilosophers { forks }
    }

    fn wants_to_eat(&self, philosopher: i32, pick: fn(i32), eat: fn(i32), put: fn(i32)) {
        let left = philosopher as usize;
        let right = (philosopher + 1) % 5;

        let left_fork = self.forks[left].clone();
        let right_fork = self.forks[right].clone();

        let _left = left_fork.lock().unwrap();
        let _right = right_fork.lock().unwrap();

        pick(philosopher);
        eat(philosopher);
        put(philosopher);
    }
}