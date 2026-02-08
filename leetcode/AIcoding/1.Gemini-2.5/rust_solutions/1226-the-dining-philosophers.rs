use std::sync::{Arc, Mutex, Condvar};
use std::thread;

struct Semaphore {
    mutex: Mutex<usize>,
    condvar: Condvar,
}

impl Semaphore {
    fn new(capacity: usize) -> Self {
        Semaphore {
            mutex: Mutex::new(capacity),
            condvar: Condvar::new(),
        }
    }

    fn acquire(&self) {
        let mut permits = self.mutex.lock().unwrap();
        while *permits == 0 {
            permits = self.condvar.wait(permits).unwrap();
        }
        *permits -= 1;
    }

    fn release(&self) {
        let mut permits = self.mutex.lock().unwrap();
        *permits += 1;
        self.condvar.notify_one();
    }
}

struct Philosopher;

impl Philosopher {
    fn eat(philosopher_id: i32, eat: impl FnOnce()) {
        eat();
    }
}

struct Solution;

impl Solution {
    fn dine() {
        let num_philosophers = 5;

        let forks: Arc<Vec<Arc<Mutex<()>>>> = Arc::new(
            (0..num_philosophers)
                .map(|_| Arc::new(Mutex::new(())))
                .collect()
        );

        let semaphore = Arc::new(Semaphore::new(num_philosophers - 1));

        let mut handles = vec![];

        for i in 0..num_philosophers {
            let forks_clone = Arc::clone(&forks);
            let semaphore_clone = Arc::clone(&semaphore);

            let handle = thread::spawn(move || {
                let left_fork_idx = i;
                let right_fork_idx = (i + 1) % num_philosophers;

                semaphore_clone.acquire();

                let _left_lock = forks_clone[left_fork_idx].lock().unwrap();
                let _right_lock = forks_clone[right_fork_idx].lock().unwrap();

                Philosopher::eat(i as i32, || {});

                semaphore_clone.release();
            });
            handles.push(handle);
        }

        for handle in handles {
            handle.join().unwrap();
        }
    }
}