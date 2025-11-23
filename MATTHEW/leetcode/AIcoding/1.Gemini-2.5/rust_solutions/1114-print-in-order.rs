use std::sync::{Mutex, Condvar};

struct Foo {
    state: Mutex<i32>,
    cvar: Condvar,
}

impl Foo {
    fn new() -> Self {
        Foo {
            state: Mutex::new(0),
            cvar: Condvar::new(),
        }
    }

    fn first(&self, print_first: impl FnOnce()) {
        let mut state = self.state.lock().unwrap();
        print_first();
        *state = 1;
        self.cvar.notify_all();
    }

    fn second(&self, print_second: impl FnOnce()) {
        let mut state = self.state.lock().unwrap();
        while *state != 1 {
            state = self.cvar.wait(state).unwrap();
        }
        print_second();
        *state = 2;
        self.cvar.notify_all();
    }

    fn third(&self, print_third: impl FnOnce()) {
        let mut state = self.state.lock().unwrap();
        while *state != 2 {
            state = self.cvar.wait(state).unwrap();
        }
        print_third();
    }
}