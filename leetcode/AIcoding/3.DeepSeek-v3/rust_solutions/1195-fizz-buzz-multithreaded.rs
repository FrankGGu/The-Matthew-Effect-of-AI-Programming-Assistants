use std::sync::{Arc, Condvar, Mutex};
use std::thread;

struct FizzBuzz {
    n: usize,
    current: Mutex<usize>,
    condvar: Condvar,
}

impl FizzBuzz {
    fn new(n: usize) -> Self {
        FizzBuzz {
            n,
            current: Mutex::new(1),
            condvar: Condvar::new(),
        }
    }

    fn fizz(&self) {
        let mut current = self.current.lock().unwrap();
        while *current <= self.n {
            current = self.condvar.wait(current).unwrap();
            if *current > self.n {
                break;
            }
            if *current % 3 == 0 && *current % 5 != 0 {
                println!("fizz");
                *current += 1;
                self.condvar.notify_all();
            }
        }
    }

    fn buzz(&self) {
        let mut current = self.current.lock().unwrap();
        while *current <= self.n {
            current = self.condvar.wait(current).unwrap();
            if *current > self.n {
                break;
            }
            if *current % 5 == 0 && *current % 3 != 0 {
                println!("buzz");
                *current += 1;
                self.condvar.notify_all();
            }
        }
    }

    fn fizzbuzz(&self) {
        let mut current = self.current.lock().unwrap();
        while *current <= self.n {
            current = self.condvar.wait(current).unwrap();
            if *current > self.n {
                break;
            }
            if *current % 15 == 0 {
                println!("fizzbuzz");
                *current += 1;
                self.condvar.notify_all();
            }
        }
    }

    fn number(&self) {
        let mut current = self.current.lock().unwrap();
        while *current <= self.n {
            current = self.condvar.wait(current).unwrap();
            if *current > self.n {
                break;
            }
            if *current % 3 != 0 && *current % 5 != 0 {
                println!("{}", *current);
                *current += 1;
                self.condvar.notify_all();
            }
        }
    }
}

fn main() {
    let n = 15;
    let fizzbuzz = Arc::new(FizzBuzz::new(n));

    let fizzbuzz_clone = Arc::clone(&fizzbuzz);
    let fizz_thread = thread::spawn(move || {
        fizzbuzz_clone.fizz();
    });

    let fizzbuzz_clone = Arc::clone(&fizzbuzz);
    let buzz_thread = thread::spawn(move || {
        fizzbuzz_clone.buzz();
    });

    let fizzbuzz_clone = Arc::clone(&fizzbuzz);
    let fizzbuzz_thread = thread::spawn(move || {
        fizzbuzz_clone.fizzbuzz();
    });

    let fizzbuzz_clone = Arc::clone(&fizzbuzz);
    let number_thread = thread::spawn(move || {
        fizzbuzz_clone.number();
    });

    fizz_thread.join().unwrap();
    buzz_thread.join().unwrap();
    fizzbuzz_thread.join().unwrap();
    number_thread.join().unwrap();
}