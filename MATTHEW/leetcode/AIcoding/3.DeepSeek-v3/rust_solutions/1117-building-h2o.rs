use std::sync::{Arc, Condvar, Mutex};
use std::thread;

struct H2O {
    h: Mutex<(i32, i32)>,
    cv: Condvar,
}

impl H2O {
    fn new() -> Self {
        H2O {
            h: Mutex::new((0, 0)),
            cv: Condvar::new(),
        }
    }

    fn hydrogen(&self, release_hydrogen: impl FnOnce()) {
        let mut h = self.h.lock().unwrap();
        *h = self.cv.wait_while(h, |(h_count, o_count)| {
            *h_count >= 2 && *o_count < 1
        }).unwrap();
        h.0 += 1;
        release_hydrogen();
        if h.0 >= 2 && h.1 >= 1 {
            h.0 -= 2;
            h.1 -= 1;
            self.cv.notify_all();
        }
    }

    fn oxygen(&self, release_oxygen: impl FnOnce()) {
        let mut h = self.h.lock().unwrap();
        *h = self.cv.wait_while(h, |(h_count, o_count)| {
            *h_count < 2 && *o_count >= 1
        }).unwrap();
        h.1 += 1;
        release_oxygen();
        if h.0 >= 2 && h.1 >= 1 {
            h.0 -= 2;
            h.1 -= 1;
            self.cv.notify_all();
        }
    }
}