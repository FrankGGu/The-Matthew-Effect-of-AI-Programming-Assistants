use std::sync::{Arc, Condvar, Mutex};

struct Foo {
    first_done: Arc<(Mutex<bool>, Condvar)>,
    second_done: Arc<(Mutex<bool>, Condvar)>,
}

impl Foo {
    fn new() -> Self {
        Foo {
            first_done: Arc::new((Mutex::new(false), Condvar::new())),
            second_done: Arc::new((Mutex::new(false), Condvar::new())),
        }
    }

    fn first(&self, print_first: impl FnOnce()) {
        print_first();
        let (lock, cvar) = &*self.first_done;
        let mut done = lock.lock().unwrap();
        *done = true;
        cvar.notify_one();
    }

    fn second(&self, print_second: impl FnOnce()) {
        let (lock, cvar) = &*self.first_done;
        let mut done = lock.lock().unwrap();
        while !*done {
            done = cvar.wait(done).unwrap();
        }
        print_second();
        let (lock, cvar) = &*self.second_done;
        let mut done = lock.lock().unwrap();
        *done = true;
        cvar.notify_one();
    }

    fn third(&self, print_third: impl FnOnce()) {
        let (lock, cvar) = &*self.second_done;
        let mut done = lock.lock().unwrap();
        while !*done {
            done = cvar.wait(done).unwrap();
        }
        print_third();
    }
}