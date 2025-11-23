use std::sync::{Arc, Mutex};
use std::thread;

pub struct FizzBuzz {
    n: i32,
    counter: Arc<Mutex<i32>>,
}

impl FizzBuzz {
    pub fn new(n: i32) -> Self {
        FizzBuzz {
            n,
            counter: Arc::new(Mutex::new(1)),
        }
    }

    pub fn fizz(print_fizz: fn() -> ()) {
        // your code here
    }

    pub fn buzz(print_buzz: fn() -> ()) {
        // your code here
    }

    pub fn fizzbuzz(print_fizzbuzz: fn() -> ()) {
        // your code here
    }

    pub fn number(print_number: fn(i32)) {
        // your code here
    }
}