use std::collections::HashMap;

struct NeighborSumService {
    nums: HashMap<i32, i32>,
}

impl NeighborSumService {
    fn new() -> Self {
        NeighborSumService {
            nums: HashMap::new(),
        }
    }

    fn update(&mut self, index: i32, value: i32) {
        self.nums.insert(index, value);
    }

    fn sum(&self, index: i32) -> i32 {
        let mut total = 0;
        if let Some(&value) = self.nums.get(&index) {
            total += value;
        }
        if let Some(&value) = self.nums.get(&(index - 1)) {
            total += value;
        }
        if let Some(&value) = self.nums.get(&(index + 1)) {
            total += value;
        }
        total
    }
}