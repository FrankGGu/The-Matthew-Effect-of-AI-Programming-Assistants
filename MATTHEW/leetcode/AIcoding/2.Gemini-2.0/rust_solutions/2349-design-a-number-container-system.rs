use std::collections::HashMap;
use std::collections::BTreeSet;

struct NumberContainers {
    num_to_idx: HashMap<i32, BTreeSet<i32>>,
    idx_to_num: HashMap<i32, i32>,
}

impl NumberContainers {
    fn new() -> Self {
        NumberContainers {
            num_to_idx: HashMap::new(),
            idx_to_num: HashMap::new(),
        }
    }

    fn change(&mut self, index: i32, number: i32) {
        if let Some(&old_number) = self.idx_to_num.get(&index) {
            self.num_to_idx.get_mut(&old_number).unwrap().remove(&index);
            if self.num_to_idx[&old_number].is_empty() {
                self.num_to_idx.remove(&old_number);
            }
        }

        self.idx_to_num.insert(index, number);

        self.num_to_idx.entry(number).or_insert(BTreeSet::new()).insert(index);
    }

    fn find(&self, number: i32) -> i32 {
        if let Some(indices) = self.num_to_idx.get(&number) {
            if let Some(&first_index) = indices.iter().next() {
                return first_index;
            }
        }
        -1
    }
}