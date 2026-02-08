use std::sync::{Arc, Mutex, Condvar};

struct FizzBuzz {
    n: i32,
    current_num: Arc<Mutex<i32>>,
    condvar: Arc<Condvar>,
}

impl FizzBuzz {
    fn new(n: i32) -> Self {
        FizzBuzz {
            n,
            current_num: Arc::new(Mutex::new(1)),
            condvar: Arc::new(Condvar::new()),
        }
    }

    fn fizz<F: Fn() -> ()>(&self, print_fizz: F) {
        loop {
            let mut num = self.current_num.lock().unwrap();
            while *num <= self.n && !(*num % 3 == 0 && *num % 5 != 0) {
                num = self.condvar.wait(num).unwrap();
            }
            if *num > self.n {
                self.condvar.notify_all();
                break;
            }
            print_fizz();
            *num += 1;
            self.condvar.notify_all();
        }
    }

    fn buzz<F: Fn() -> ()>(&self, print_buzz: F) {
        loop {
            let mut num = self.current_num.lock().unwrap();
            while *num <= self.n && !(*num % 5 == 0 && *num % 3 != 0) {
                num = self.condvar.wait(num).unwrap();
            }
            if *num > self.n {
                self.condvar.notify_all();
                break;
            }
            print_buzz();
            *num += 1;
            self.condvar.notify_all();
        }
    }

    fn fizzbuzz<F: Fn() -> ()>(&self, print_fizzbuzz: F) {
        loop {
            let mut num = self.current_num.lock().unwrap();
            while *num <= self.n && !(*num % 15 == 0) {
                num = self.condvar.wait(num).unwrap();
            }
            if *num > self.n {
                self.condvar.notify_all();
                break;
            }
            print_fizzbuzz();
            *num += 1;
            self.condvar.notify_all();
        }
    }

    fn number<F: Fn(i32) -> ()>(&self, print_number: F) {
        loop {
            let mut num = self.current_num.lock().unwrap();
            while *num <= self.n && !(*num % 3 != 0 && *num % 5 != 0) {
                num = self.condvar.wait(num).unwrap();
            }
            if *num > self.n {
                self.condvar.notify_all();
                break;
            }
            print_number(*num);
            *num += 1;
            self.condvar.notify_all();
        }
    }
}