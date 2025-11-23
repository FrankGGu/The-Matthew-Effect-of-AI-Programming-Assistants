use std::sync::{Mutex, Condvar};

struct FooBar {
    n: i32,
    mutex: Mutex<bool>, // true for foo's turn, false for bar's turn
    condvar: Condvar,
}

impl FooBar {
    fn new(n: i32) -> Self {
        FooBar {
            n,
            mutex: Mutex::new(true), // Foo starts first
            condvar: Condvar::new(),
        }
    }

    fn foo(&self, print_foo: impl Fn()) {
        let mut guard = self.mutex.lock().unwrap();
        for _ in 0..self.n {
            guard = self.condvar.wait_while(guard, |&mut turn| !turn).unwrap();

            print_foo();

            *guard = false; // It's now bar's turn

            self.condvar.notify_one();
        }
    }

    fn bar(&self, print_bar: impl Fn()) {
        let mut guard = self.mutex.lock().unwrap();
        for _ in 0..self.n {
            guard = self.condvar.wait_while(guard, |&mut turn| turn).unwrap();

            print_bar();

            *guard = true; // It's now foo's turn

            self.condvar.notify_one();
        }
    }
}