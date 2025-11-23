use std::sync::{Arc, Mutex};
use std::thread;

struct FooBar {
    n: i32,
    foo: Arc<Mutex<bool>>,
}

impl FooBar {
    fn new(n: i32) -> Self {
        FooBar {
            n,
            foo: Arc::new(Mutex::new(true)),
        }
    }

    fn foo(&self) {
        for _ in 0..self.n {
            let mut f = self.foo.lock().unwrap();
            while !*f {
                drop(f);
                f = self.foo.lock().unwrap();
            }
            print!("Foo");
            *f = false;
        }
    }

    fn bar(&self) {
        for _ in 0..self.n {
            let mut f = self.foo.lock().unwrap();
            while *f {
                drop(f);
                f = self.foo.lock().unwrap();
            }
            print!("Bar");
            *f = true;
        }
    }
}

fn main() {
    let n = 5;
    let foobar = FooBar::new(n);
    let foobar_clone = foobar.foo.clone();

    let foo_thread = thread::spawn(move || {
        foobar.foo();
    });

    let bar_thread = thread::spawn(move || {
        let f = FooBar {
            n,
            foo: foobar_clone,
        };
        f.bar();
    });

    foo_thread.join().unwrap();
    bar_thread.join().unwrap();
}