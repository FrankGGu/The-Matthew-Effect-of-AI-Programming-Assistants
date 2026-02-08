use std::sync::{Arc, Mutex, Condvar};

struct H2O {
    hydrogen_count: Arc<Mutex<usize>>,
    oxygen_count: Arc<Mutex<usize>>,
    hydrogen_cv: Arc<Condvar>,
    oxygen_cv: Arc<Condvar>,
}

impl H2O {
    fn new() -> Self {
        H2O {
            hydrogen_count: Arc::new(Mutex::new(0)),
            oxygen_count: Arc::new(Mutex::new(0)),
            hydrogen_cv: Arc::new(Condvar::new()),
            oxygen_cv: Arc::new(Condvar::new()),
        }
    }

    fn hydrogen(&self, release_hydrogen: impl FnOnce()) {
        let mut hydrogen_count = self.hydrogen_count.lock().unwrap();
        *hydrogen_count += 1;

        while *hydrogen_count < 2 || *self.oxygen_count.lock().unwrap() < 1 {
            hydrogen_count = self.hydrogen_cv.wait(hydrogen_count).unwrap();
        }

        release_hydrogen();
        *hydrogen_count -= 1;

        if *hydrogen_count == 1 && *self.oxygen_count.lock().unwrap() >= 1 {
            self.oxygen_cv.notify_one();
        } else if *hydrogen_count == 0 && *self.oxygen_count.lock().unwrap() >= 1 {
            self.oxygen_cv.notify_one();
        }
    }

    fn oxygen(&self, release_oxygen: impl FnOnce()) {
        let mut oxygen_count = self.oxygen_count.lock().unwrap();
        *oxygen_count += 1;

        while *self.hydrogen_count.lock().unwrap() < 2 {
            oxygen_count = self.oxygen_cv.wait(oxygen_count).unwrap();
        }

        release_oxygen();
        *oxygen_count -= 1;

        self.hydrogen_cv.notify_all();
    }
}