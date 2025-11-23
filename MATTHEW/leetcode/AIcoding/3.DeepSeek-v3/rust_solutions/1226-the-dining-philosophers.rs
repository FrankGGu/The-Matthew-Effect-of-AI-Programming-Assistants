use std::sync::{Arc, Mutex};
use std::thread;

struct DiningPhilosophers {
    forks: Vec<Mutex<()>>,
}

impl DiningPhilosophers {
    fn new() -> Self {
        DiningPhilosophers {
            forks: (0..5).map(|_| Mutex::new(())).collect(),
        }
    }

    fn wants_to_eat(
        &self,
        philosopher: i32,
        pick_left_fork: impl Fn(),
        pick_right_fork: impl Fn(),
        eat: impl Fn(),
        put_left_fork: impl Fn(),
        put_right_fork: impl Fn(),
    ) {
        let left = philosopher as usize;
        let right = (philosopher as usize + 1) % 5;

        if philosopher % 2 == 0 {
            let _left = self.forks[left].lock().unwrap();
            let _right = self.forks[right].lock().unwrap();

            pick_left_fork();
            pick_right_fork();
            eat();
            put_right_fork();
            put_left_fork();
        } else {
            let _right = self.forks[right].lock().unwrap();
            let _left = self.forks[left].lock().unwrap();

            pick_right_fork();
            pick_left_fork();
            eat();
            put_left_fork();
            put_right_fork();
        }
    }
}