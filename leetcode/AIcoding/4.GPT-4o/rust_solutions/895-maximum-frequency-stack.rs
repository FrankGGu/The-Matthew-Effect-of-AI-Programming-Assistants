use std::collections::{HashMap, VecDeque};

struct FreqStack {
    freq: HashMap<i32, i32>,
    max_freq: i32,
    stacks: HashMap<i32, VecDeque<i32>>,
}

impl FreqStack {
    fn new() -> Self {
        FreqStack {
            freq: HashMap::new(),
            max_freq: 0,
            stacks: HashMap::new(),
        }
    }

    fn push(&mut self, val: i32) {
        let count = self.freq.entry(val).or_insert(0);
        *count += 1;
        self.max_freq = self.max_freq.max(*count);

        self.stacks.entry(*count).or_insert_with(VecDeque::new).push_back(val);
    }

    fn pop(&mut self) -> i32 {
        if let Some(val) = self.stacks.get_mut(&self.max_freq).and_then(|stack| stack.pop_back()) {
            let count = self.freq.get_mut(&val).unwrap();
            *count -= 1;
            if *count == 0 {
                self.freq.remove(&val);
                self.max_freq -= 1;
            }
            return val;
        }
        0
    }
}