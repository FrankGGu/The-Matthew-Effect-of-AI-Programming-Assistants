use std::sync::{Arc, Condvar, Mutex};
use std::thread;

struct ZeroEvenOdd {
    n: usize,
    state: Mutex<usize>,
    cv_zero: Condvar,
    cv_even: Condvar,
    cv_odd: Condvar,
}

impl ZeroEvenOdd {
    fn new(n: usize) -> Self {
        ZeroEvenOdd {
            n,
            state: Mutex::new(0),
            cv_zero: Condvar::new(),
            cv_even: Condvar::new(),
            cv_odd: Condvar::new(),
        }
    }

    fn zero(&self, print_number: impl Fn(usize)) {
        for i in 1..=self.n {
            let mut state = self.state.lock().unwrap();
            while *state != 0 {
                state = self.cv_zero.wait(state).unwrap();
            }
            print_number(0);
            *state = if i % 2 == 1 { 1 } else { 2 };
            if *state == 1 {
                self.cv_odd.notify_one();
            } else {
                self.cv_even.notify_one();
            }
        }
    }

    fn even(&self, print_number: impl Fn(usize)) {
        for i in (2..=self.n).step_by(2) {
            let mut state = self.state.lock().unwrap();
            while *state != 2 {
                state = self.cv_even.wait(state).unwrap();
            }
            print_number(i);
            *state = 0;
            self.cv_zero.notify_one();
        }
    }

    fn odd(&self, print_number: impl Fn(usize)) {
        for i in (1..=self.n).step_by(2) {
            let mut state = self.state.lock().unwrap();
            while *state != 1 {
                state = self.cv_odd.wait(state).unwrap();
            }
            print_number(i);
            *state = 0;
            self.cv_zero.notify_one();
        }
    }
}

fn main() {
    let n = 5;
    let zeo = Arc::new(ZeroEvenOdd::new(n));
    let mut handles = vec![];

    let zeo_clone = Arc::clone(&zeo);
    handles.push(thread::spawn(move || {
        zeo_clone.zero(|x| print!("{}", x));
    }));

    let zeo_clone = Arc::clone(&zeo);
    handles.push(thread::spawn(move || {
        zeo_clone.even(|x| print!("{}", x));
    }));

    let zeo_clone = Arc::clone(&zeo);
    handles.push(thread::spawn(move || {
        zeo_clone.odd(|x| print!("{}", x));
    }));

    for handle in handles {
        handle.join().unwrap();
    }
    println!();
}