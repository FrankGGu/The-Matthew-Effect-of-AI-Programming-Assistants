use std::collections::{HashMap, BTreeSet};

struct NumberContainers {
    index_to_number: HashMap<i32, i32>,
    number_to_indices: HashMap<i32, BTreeSet<i32>>,
}

impl NumberContainers {
    fn new() -> Self {
        NumberContainers {
            index_to_number: HashMap::new(),
            number_to_indices: HashMap::new(),
        }
    }

    fn change(&mut self, index: i32, number: i32) {
        let old_number_opt = self.index_to_number.insert(index, number);

        if let Some(old_number) = old_number_opt {
            if let Some(indices_set) = self.number_to_indices.get_mut(&old_number) {
                indices_set.remove(&index);
            }
        }

        self.number_to_indices
            .entry(number)
            .or_insert_with(BTreeSet::new)
            .insert(index);
    }

    fn find(&self, number: i32) -> i32 {
        if let Some(indices_set) = self.number_to_indices.get(&number) {
            if let Some(&min_index) = indices_set.iter().next() {
                return min_index;
            }
        }
        -1
    }
}