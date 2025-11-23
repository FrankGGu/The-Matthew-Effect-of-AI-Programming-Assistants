use std::collections::{HashMap, VecDeque};

struct FreqStack {
    freq: HashMap<i32, i32>,
    group: HashMap<i32, Vec<i32>>,
    max_freq: i32,
}

impl FreqStack {
    fn new() -> Self {
        FreqStack {
            freq: HashMap::new(),
            group: HashMap::new(),
            max_freq: 0,
        }
    }

    fn push(&mut self, val: i32) {
        let f = self.freq.entry(val).or_insert(0);
        *f += 1;
        self.max_freq = self.max_freq.max(*f);

        self.group.entry(*f).or_insert(Vec::new()).push(val);
    }

    fn pop(&mut self) -> i32 {
        let x = self.group.get_mut(&self.max_freq).unwrap().pop().unwrap();
        *self.freq.get_mut(&x).unwrap() -= 1;

        if self.group[&self.max_freq].is_empty() {
            self.max_freq -= 1;
        }

        x
    }
}