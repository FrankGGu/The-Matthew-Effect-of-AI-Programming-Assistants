use std::sync::{Arc, Mutex, Condvar};
use std::thread;

struct DiningPhilosophers {
    forks: Vec<Arc<(Mutex<()>, Condvar)>>,
}

impl DiningPhilosophers {
    fn new() -> Self {
        let forks = (0..5).map(|_| Arc::new((Mutex::new(()), Condvar::new()))).collect();
        DiningPhilosophers { forks }
    }

    fn wants_to_eat(&self, philosopher: i32, pick_left: Box<dyn Fn() + Send + Sync + 'static>, eat: Box<dyn Fn() + Send + Sync + 'static>, put_right: Box<dyn Fn() + Send + Sync + 'static>, put_left: Box<dyn Fn() + Send + Sync + 'static>) {
        let left_fork_index = philosopher as usize;
        let right_fork_index = (philosopher + 1) as usize % 5;

        let (left_mutex, left_cv) = &*self.forks[left_fork_index];
        let (right_mutex, right_cv) = &*self.forks[right_fork_index];

        pick_left();
        let mut left_guard = left_mutex.lock().unwrap();

        let mut right_guard = right_mutex.lock().unwrap();

        eat();

        put_right();
        drop(right_guard);
        right_cv.notify_one();

        put_left();
        drop(left_guard);
        left_cv.notify_one();
    }
}