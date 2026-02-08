use std::collections::{HashMap, HashSet};

struct NumberContainers {
    num_to_index: HashMap<i32, i32>,
    index_to_nums: HashMap<i32, HashSet<i32>>,
}

impl NumberContainers {
    fn new() -> Self {
        NumberContainers {
            num_to_index: HashMap::new(),
            index_to_nums: HashMap::new(),
        }
    }

    fn change(&mut self, index: i32, number: i32) {
        if let Some(&old_number) = self.num_to_index.get(&index) {
            if let Some(nums) = self.index_to_nums.get_mut(&old_number) {
                nums.remove(&index);
                if nums.is_empty() {
                    self.index_to_nums.remove(&old_number);
                }
            }
        }
        self.num_to_index.insert(index, number);
        self.index_to_nums.entry(number).or_insert_with(HashSet::new).insert(index);
    }

    fn find(&self, number: i32) -> i32 {
        if let Some(indices) = self.index_to_nums.get(&number) {
            *indices.iter().next().unwrap()
        } else {
            -1
        }
    }
}