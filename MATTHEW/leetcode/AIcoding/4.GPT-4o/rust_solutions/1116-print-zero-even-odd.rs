use std::sync::{Arc, Mutex};
use std::thread;

struct ZeroEvenOdd {
    n: i32,
    zero: Arc<Mutex<bool>>,
    even: Arc<Mutex<bool>>,
    odd: Arc<Mutex<bool>>,
}

impl ZeroEvenOdd {
    fn new(n: i32) -> Self {
        ZeroEvenOdd {
            n,
            zero: Arc::new(Mutex::new(true)),
            even: Arc::new(Mutex::new(false)),
            odd: Arc::new(Mutex::new(false)),
        }
    }

    fn zero(&self, print_number: &dyn Fn()) {
        for _ in 0..self.n {
            let mut zero_lock = self.zero.lock().unwrap();
            while !*zero_lock {
                zero_lock = self.zero.lock().unwrap();
            }
            print_number();
            *zero_lock = false;
            if self.n % 2 == 0 {
                *self.even.lock().unwrap() = true;
            } else {
                *self.odd.lock().unwrap() = true;
            }
        }
    }

    fn odd(&self, print_number: &dyn Fn()) {
        for i in 1..=self.n {
            if i % 2 == 1 {
                let mut odd_lock = self.odd.lock().unwrap();
                while !*odd_lock {
                    odd_lock = self.odd.lock().unwrap();
                }
                print_number();
                *self.odd.lock().unwrap() = false;
                *self.zero.lock().unwrap() = true;
            }
        }
    }

    fn even(&self, print_number: &dyn Fn()) {
        for i in 1..=self.n {
            if i % 2 == 0 {
                let mut even_lock = self.even.lock().unwrap();
                while !*even_lock {
                    even_lock = self.even.lock().unwrap();
                }
                print_number();
                *self.even.lock().unwrap() = false;
                *self.zero.lock().unwrap() = true;
            }
        }
    }
}

fn main() {
    // Example usage
    let n = 5;
    let zero_even_odd = ZeroEvenOdd::new(n);
    let zero_thread = thread::spawn(move || {
        zero_even_odd.zero(|| print!("0"));
    });
    let odd_thread = thread::spawn(move || {
        zero_even_odd.odd(|| print!("1"));
    });
    let even_thread = thread::spawn(move || {
        zero_even_odd.even(|| print!("2"));
    });

    zero_thread.join().unwrap();
    odd_thread.join().unwrap();
    even_thread.join().unwrap();
}