use std::sync::{Arc, Condvar, Mutex};
use std::thread;

struct ZeroEvenOdd {
    n: i32,
    zero: Arc<(Mutex<bool>, Condvar)>,
    even: Arc<(Mutex<bool>, Condvar)>,
    odd: Arc<(Mutex<bool>, Condvar)>,
    count: Arc<Mutex<i32>>,
}

impl ZeroEvenOdd {
    fn new(n: i32) -> Self {
        ZeroEvenOdd {
            n,
            zero: Arc::new((Mutex::new(true), Condvar::new())),
            even: Arc::new((Mutex::new(false), Condvar::new())),
            odd: Arc::new((Mutex::new(false), Condvar::new())),
            count: Arc::new(Mutex::new(1)),
        }
    }

    fn zero(&self, print_number: &dyn Fn(i32)) {
        let (lock, cvar) = &*self.zero;
        let (count_lock, _) = &*self.count;
        while *count_lock.lock().unwrap() <= self.n {
            let mut started = lock.lock().unwrap();
            while !*started && *count_lock.lock().unwrap() <= self.n {
                started = cvar.wait(started).unwrap();
            }
            if *count_lock.lock().unwrap() > self.n {
                break;
            }
            print_number(0);
            let mut count = count_lock.lock().unwrap();
            if *count % 2 == 1 {
                let (lock_odd, cvar_odd) = &*self.odd;
                let mut odd_started = lock_odd.lock().unwrap();
                *odd_started = true;
                cvar_odd.notify_one();
            } else {
                let (lock_even, cvar_even) = &*self.even;
                let mut even_started = lock_even.lock().unwrap();
                *even_started = true;
                cvar_even.notify_one();
            }
            *started = false;
            cvar.notify_one();
        }
    }

    fn even(&self, print_number: &dyn Fn(i32)) {
        let (lock, cvar) = &*self.even;
        let (count_lock, _) = &*self.count;
        while *count_lock.lock().unwrap() <= self.n {
            let mut started = lock.lock().unwrap();
            while !*started && *count_lock.lock().unwrap() <= self.n {
                started = cvar.wait(started).unwrap();
            }
            if *count_lock.lock().unwrap() > self.n {
                break;
            }
            print_number(*count_lock.lock().unwrap());
            let mut zero_lock = self.zero.0.lock().unwrap();
            *zero_lock = true;
            self.zero.1.notify_one();

            *started = false;
            let mut count = count_lock.lock().unwrap();
            *count += 1;
            drop(count);
            cvar.notify_one();
        }
    }

    fn odd(&self, print_number: &dyn Fn(i32)) {
        let (lock, cvar) = &*self.odd;
        let (count_lock, _) = &*self.count;
        while *count_lock.lock().unwrap() <= self.n {
            let mut started = lock.lock().unwrap();
            while !*started && *count_lock.lock().unwrap() <= self.n {
                started = cvar.wait(started).unwrap();
            }
            if *count_lock.lock().unwrap() > self.n {
                break;
            }
            print_number(*count_lock.lock().unwrap());
             let mut zero_lock = self.zero.0.lock().unwrap();
            *zero_lock = true;
            self.zero.1.notify_one();

            *started = false;
            let mut count = count_lock.lock().unwrap();
            *count += 1;
            drop(count);
            cvar.notify_one();
        }
    }
}