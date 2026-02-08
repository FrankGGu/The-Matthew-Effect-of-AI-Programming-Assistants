use std::sync::{Arc, Mutex};
use std::thread;

struct Foo {
    turn: Arc<Mutex<i32>>,
}

impl Foo {
    fn new() -> Self {
        Foo {
            turn: Arc::new(Mutex::new(0)),
        }
    }

    fn first(&self, print_first: impl FnOnce()) {
        print_first();
        let mut turn = self.turn.lock().unwrap();
        *turn = 1;
    }

    fn second(&self, print_second: impl FnOnce()) {
        while *self.turn.lock().unwrap() < 1 {}
        print_second();
        let mut turn = self.turn.lock().unwrap();
        *turn = 2;
    }

    fn third(&self, print_third: impl FnOnce()) {
        while *self.turn.lock().unwrap() < 2 {}
        print_third();
    }
}