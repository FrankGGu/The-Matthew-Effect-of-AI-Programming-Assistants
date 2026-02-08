use std::sync::{Arc, Mutex, Condvar};

struct FizzBuzz {
    n: i32,
    current: Mutex<i32>,
    fizz: Condvar,
    buzz: Condvar,
    fizzbuzz: Condvar,
    number: Condvar,
}

impl FizzBuzz {
    fn new(n: i32) -> Self {
        FizzBuzz {
            n,
            current: Mutex::new(1),
            fizz: Condvar::new(),
            buzz: Condvar::new(),
            fizzbuzz: Condvar::new(),
            number: Condvar::new(),
        }
    }

    fn fizz(&self, print_fizz: &dyn Fn()) {
        let mut current = self.current.lock().unwrap();
        while *current <= self.n {
            if *current % 3 == 0 && *current % 5 != 0 {
                print_fizz();
                *current += 1;
                self.number.notify_one();
            } else {
                current = self.fizz.wait(current).unwrap();
            }
        }
    }

    fn buzz(&self, print_buzz: &dyn Fn()) {
        let mut current = self.current.lock().unwrap();
        while *current <= self.n {
            if *current % 5 == 0 && *current % 3 != 0 {
                print_buzz();
                *current += 1;
                self.number.notify_one();
            } else {
                current = self.buzz.wait(current).unwrap();
            }
        }
    }

    fn fizzbuzz(&self, print_fizzbuzz: &dyn Fn()) {
        let mut current = self.current.lock().unwrap();
        while *current <= self.n {
            if *current % 3 == 0 && *current % 5 == 0 {
                print_fizzbuzz();
                *current += 1;
                self.number.notify_one();
            } else {
                current = self.fizzbuzz.wait(current).unwrap();
            }
        }
    }

    fn number(&self, print_number: &dyn Fn(i32)) {
        let mut current = self.current.lock().unwrap();
        while *current <= self.n {
            if *current % 3 != 0 && *current % 5 != 0 {
                print_number(*current);
                *current += 1;
                self.number.notify_one();
            } else {
                current = self.number.wait(current).unwrap();
            }

            if *current % 3 == 0 && *current % 5 != 0 {
                self.fizz.notify_one();
            } else if *current % 5 == 0 && *current % 3 != 0 {
                self.buzz.notify_one();
            } else if *current % 3 == 0 && *current % 5 == 0 {
                self.fizzbuzz.notify_one();
            }
        }
    }
}