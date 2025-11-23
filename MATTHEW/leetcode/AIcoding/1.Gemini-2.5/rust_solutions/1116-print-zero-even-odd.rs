use std::sync::{Arc, Mutex, Condvar};

struct ZeroEvenOdd {
    n: i32,
    state: Arc<(Mutex<SharedState>, Condvar, Condvar, Condvar)>,
}

struct SharedState {
    current_num: i32,
    turn: i32, // 0: zero, 1: odd, 2: even
}

impl ZeroEvenOdd {
    fn new(n: i32) -> Self {
        ZeroEvenOdd {
            n,
            state: Arc::new((
                Mutex::new(SharedState {
                    current_num: 1,
                    turn: 0,
                }),
                Condvar::new(), // zero_cv
                Condvar::new(), // odd_cv
                Condvar::new(), // even_cv
            )),
        }
    }

    fn zero(&self, print_number: impl Fn(i32)) {
        let (lock, zero_cv, odd_cv, even_cv) = &*self.state;
        let mut shared_state = lock.lock().unwrap();

        for _ in 0..self.n {
            while shared_state.turn != 0 {
                shared_state = zero_cv.wait(shared_state).unwrap();
            }

            print_number(0);

            if shared_state.current_num % 2 == 1 {
                shared_state.turn = 1;
                odd_cv.notify_one();
            } else {
                shared_state.turn = 2;
                even_cv.notify_one();
            }
        }
    }

    fn even(&self, print_number: impl Fn(i32)) {
        let (lock, zero_cv, odd_cv, even_cv) = &*self.state;
        let mut shared_state = lock.lock().unwrap();

        while shared_state.current_num <= self.n {
            while shared_state.turn != 2 {
                shared_state = even_cv.wait(shared_state).unwrap();
            }

            if shared_state.current_num > self.n {
                break;
            }

            print_number(shared_state.current_num);
            shared_state.current_num += 1;
            shared_state.turn = 0;
            zero_cv.notify_one();
        }
    }

    fn odd(&self, print_number: impl Fn(i32)) {
        let (lock, zero_cv, odd_cv, even_cv) = &*self.state;
        let mut shared_state = lock.lock().unwrap();

        while shared_state.current_num <= self.n {
            while shared_state.turn != 1 {
                shared_state = odd_cv.wait(shared_state).unwrap();
            }

            if shared_state.current_num > self.n {
                break;
            }

            print_number(shared_state.current_num);
            shared_state.current_num += 1;
            shared_state.turn = 0;
            zero_cv.notify_one();
        }
    }
}