impl Solution {

use std::sync::{Arc, Mutex};
use std::thread;

struct Foo {
    done: Arc<Mutex<Vec<bool>>>,
}

impl Foo {
    fn new() -> Self {
        Foo {
            done: Arc::new(Mutex::new(vec![false, false, false])),
        }
    }

    fn first(&self) {
        let mut done = self.done.lock().unwrap();
        done[0] = true;
    }

    fn second(&self) {
        let mut done = self.done.lock().unwrap();
        while !done[0] {
            std::thread::yield_now();
        }
        done[1] = true;
    }

    fn third(&self) {
        let mut done = self.done.lock().unwrap();
        while !done[1] {
            std::thread::yield_now();
        }
        done[2] = true;
    }
}
}