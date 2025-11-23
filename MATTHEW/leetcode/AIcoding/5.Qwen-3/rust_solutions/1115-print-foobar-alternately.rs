impl Solution {

use std::sync::{Arc, Mutex};
use std::thread;

struct FooBar {
    n: i32,
    print_foo: Arc<Mutex<bool>>,
    print_bar: Arc<Mutex<bool>>,
}

impl FooBar {
    fn new(n: i32) -> Self {
        FooBar {
            n,
            print_foo: Arc::new(Mutex::new(true)),
            print_bar: Arc::new(Mutex::new(false)),
        }
    }

    fn foo(&self, callback: &dyn Fn()) {
        for _ in 0..self.n {
            let mut can_print = self.print_foo.lock().unwrap();
            while !*can_print {
                drop(can_print);
                thread::sleep(std::time::Duration::from_micros(1));
                can_print = self.print_foo.lock().unwrap();
            }
            callback();
            *can_print = false;
            let mut bar_lock = self.print_bar.lock().unwrap();
            *bar_lock = true;
        }
    }

    fn bar(&self, callback: &dyn Fn()) {
        for _ in 0..self.n {
            let mut can_print = self.print_bar.lock().unwrap();
            while !*can_print {
                drop(can_print);
                thread::sleep(std::time::Duration::from_micros(1));
                can_print = self.print_bar.lock().unwrap();
            }
            callback();
            *can_print = false;
            let mut foo_lock = self.print_foo.lock().unwrap();
            *foo_lock = true;
        }
    }
}

fn main() {
    let fb = FooBar::new(10);
    let fb_clone = Arc::new(fb);
    let fb_clone2 = Arc::clone(&fb_clone);

    thread::spawn(move || {
        fb_clone.foo(&|| {
            print!("Foo");
        });
    });

    thread::spawn(move || {
        fb_clone2.bar(&|| {
            print!("Bar");
        });
    });

    thread::sleep(std::time::Duration::from_secs(1));
}
}