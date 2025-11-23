use std::sync::{Arc, Mutex, Condvar};
use std::thread;

struct FooBar {
    n: i32,
    foo_done: Arc<(Mutex<bool>, Condvar)>,
    bar_done: Arc<(Mutex<bool>, Condvar)>,
}

impl FooBar {
    fn new(n: i32) -> Self {
        FooBar {
            n,
            foo_done: Arc::new((Mutex::new(false), Condvar::new())),
            bar_done: Arc::new((Mutex::new(false), Condvar::new())),
        }
    }

    fn foo(&self, print_foo: &dyn Fn()) {
        for _i in 0..self.n {
            let (lock, cvar) = &*self.foo_done;
            let mut done = lock.lock().unwrap();
            while *done {
                done = cvar.wait(done).unwrap();
            }
            print_foo();
            *done = true;
            self.bar_done.1.notify_one();
        }
    }

    fn bar(&self, print_bar: &dyn Fn()) {
        for _i in 0..self.n {
            let (lock, cvar) = &*self.bar_done;
            let mut done = lock.lock().unwrap();
            while !*done {
                done = cvar.wait(done).unwrap();
            }
            print_bar();
            *done = false;
            self.foo_done.1.notify_one();
        }
    }
}