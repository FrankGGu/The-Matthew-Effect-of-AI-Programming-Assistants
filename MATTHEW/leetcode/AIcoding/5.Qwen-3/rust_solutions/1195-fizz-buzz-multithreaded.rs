impl Solution {

use std::sync::{Arc, Mutex};
use std::thread;

struct FizzBuzz {
    n: i32,
    count: i32,
    lock: Arc<Mutex<i32>>,
}

impl FizzBuzz {
    fn new(n: i32) -> Self {
        FizzBuzz {
            n,
            count: 1,
            lock: Arc::new(Mutex::new(1)),
        }
    }

    fn fizz(&self, print_fizz: &dyn Fn()) {
        while *self.lock.lock().unwrap() <= self.n {
            let mut current = self.lock.lock().unwrap();
            if *current % 3 == 0 && *current % 5 != 0 {
                print_fizz();
                *current += 1;
            } else {
                thread::sleep(std::time::Duration::from_millis(1));
            }
        }
    }

    fn buzz(&self, print_buzz: &dyn Fn()) {
        while *self.lock.lock().unwrap() <= self.n {
            let mut current = self.lock.lock().unwrap();
            if *current % 5 == 0 && *current % 3 != 0 {
                print_buzz();
                *current += 1;
            } else {
                thread::sleep(std::time::Duration::from_millis(1));
            }
        }
    }

    fn fizzbuzz(&self, print_fizzbuzz: &dyn Fn()) {
        while *self.lock.lock().unwrap() <= self.n {
            let mut current = self.lock.lock().unwrap();
            if *current % 3 == 0 && *current % 5 == 0 {
                print_fizzbuzz();
                *current += 1;
            } else {
                thread::sleep(std::time::Duration::from_millis(1));
            }
        }
    }

    fn number(&self, print_number: &dyn Fn(i32)) {
        while *self.lock.lock().unwrap() <= self.n {
            let mut current = self.lock.lock().unwrap();
            if *current % 3 != 0 && *current % 5 != 0 {
                print_number(*current);
                *current += 1;
            } else {
                thread::sleep(std::time::Duration::from_millis(1));
            }
        }
    }
}

fn main() {}
}