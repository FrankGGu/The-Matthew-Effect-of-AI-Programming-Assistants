use std::collections::HashMap;

struct FreqStack {
    freq_map: HashMap<i32, i32>,
    freq_stacks: HashMap<i32, Vec<i32>>,
    max_freq: i32,
}

impl FreqStack {
    fn new() -> Self {
        FreqStack {
            freq_map: HashMap::new(),
            freq_stacks: HashMap::new(),
            max_freq: 0,
        }
    }

    fn push(&mut self, val: i32) {
        let current_freq = self.freq_map.entry(val).or_insert(0);
        *current_freq += 1;
        let new_freq = *current_freq;

        if new_freq > self.max_freq {
            self.max_freq = new_freq;
        }

        self.freq_stacks.entry(new_freq).or_insert_with(Vec::new).push(val);
    }

    fn pop(&mut self) -> i32 {
        let val = self.freq_stacks.get_mut(&self.max_freq).unwrap().pop().unwrap();

        let current_freq = self.freq_map.get_mut(&val).unwrap();
        *current_freq -= 1;

        if self.freq_stacks.get(&self.max_freq).unwrap().is_empty() {
            self.max_freq -= 1;
        }

        val
    }
}