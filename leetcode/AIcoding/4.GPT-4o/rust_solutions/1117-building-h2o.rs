use std::sync::{Arc, Mutex};
use std::thread;

struct H2O {
    h_count: Arc<Mutex<usize>>,
    o_count: Arc<Mutex<usize>>,
}

impl H2O {
    fn new() -> Self {
        H2O {
            h_count: Arc::new(Mutex::new(0)),
            o_count: Arc::new(Mutex::new(0)),
        }
    }

    fn hydrogen(&self, release: fn()) {
        let mut h = self.h_count.lock().unwrap();
        while *h >= 2 {
            drop(h);
            thread::yield_now();
            h = self.h_count.lock().unwrap();
        }
        *h += 1;
        release();
        drop(h);
    }

    fn oxygen(&self, release: fn()) {
        let mut o = self.o_count.lock().unwrap();
        while *o >= 1 {
            drop(o);
            thread::yield_now();
            o = self.o_count.lock().unwrap();
        }
        *o += 1;
        release();
        drop(o);
    }

    fn create_h2o(&self) {
        while *self.h_count.lock().unwrap() >= 2 && *self.o_count.lock().unwrap() >= 1 {
            let mut h = self.h_count.lock().unwrap();
            let mut o = self.o_count.lock().unwrap();
            if *h >= 2 && *o >= 1 {
                *h -= 2;
                *o -= 1;
                // H2O molecule is created
            }
        }
    }
}