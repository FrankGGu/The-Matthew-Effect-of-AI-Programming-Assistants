use std::collections::{HashMap, BTreeMap};

struct FreqStack {
    freq: HashMap<i32, i32>,
    group: BTreeMap<i32, Vec<i32>>,
    max_freq: i32,
}

impl FreqStack {
    fn new() -> Self {
        FreqStack {
            freq: HashMap::new(),
            group: BTreeMap::new(),
            max_freq: 0,
        }
    }

    fn push(&mut self, val: i32) {
        let count = self.freq.entry(val).or_insert(0);
        *count += 1;
        let current_freq = *count;
        self.group.entry(current_freq).or_insert(Vec::new()).push(val);
        if current_freq > self.max_freq {
            self.max_freq = current_freq;
        }
    }

    fn pop(&mut self) -> i32 {
        let max_group = self.group.get_mut(&self.max_freq).unwrap();
        let val = max_group.pop().unwrap();
        *self.freq.get_mut(&val).unwrap() -= 1;
        if max_group.is_empty() {
            self.group.remove(&self.max_freq);
            self.max_freq -= 1;
        }
        val
    }
}