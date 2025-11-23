use std::collections::HashMap;
use std::collections::BTreeSet;

struct NumberContainers {
    index_to_num: HashMap<i32, i32>,
    num_to_indices: HashMap<i32, BTreeSet<i32>>,
}

impl NumberContainers {
    fn new() -> Self {
        NumberContainers {
            index_to_num: HashMap::new(),
            num_to_indices: HashMap::new(),
        }
    }

    fn change(&mut self, index: i32, number: i32) {
        if let Some(old_num) = self.index_to_num.get(&index) {
            if let Some(indices) = self.num_to_indices.get_mut(old_num) {
                indices.remove(&index);
            }
        }
        self.index_to_num.insert(index, number);
        self.num_to_indices.entry(number).or_default().insert(index);
    }

    fn find(&self, number: i32) -> i32 {
        if let Some(indices) = self.num_to_indices.get(&number) {
            if let Some(&min_index) = indices.iter().next() {
                return min_index;
            }
        }
        -1
    }
}