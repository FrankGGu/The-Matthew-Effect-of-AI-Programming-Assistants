use std::sync::{Arc, Condvar, Mutex};
use std::thread;

struct FooBar {
    n: usize,
    foo_turn: Arc<(Mutex<bool>, Condvar)>,
}

impl FooBar {
    fn new(n: usize) -> Self {
        FooBar {
            n,
            foo_turn: Arc::new((Mutex::new(true), Condvar::new())),
        }
    }

    fn foo(&self, print_foo: impl Fn()) {
        let (lock, cvar) = &*self.foo_turn;
        for _ in 0..self.n {
            let mut guard = lock.lock().unwrap();
            while !*guard {
                guard = cvar.wait(guard).unwrap();
            }
            print_foo();
            *guard = false;
            cvar.notify_one();
        }
    }

    fn bar(&self, print_bar: impl Fn()) {
        let (lock, cvar) = &*self.foo_turn;
        for _ in 0..self.n {
            let mut guard = lock.lock().unwrap();
            while *guard {
                guard = cvar.wait(guard).unwrap();
            }
            print_bar();
            *guard = true;
            cvar.notify_one();
        }
    }
}