impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn minimum_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut set = HashSet::new();
        for &num in &nums {
            set.insert(num);
        }
        let mut operations = 0;
        while set.len() > 0 {
            let mut to_remove = vec![];
            for &num in &set {
                if num % k == 0 {
                    to_remove.push(num);
                }
            }
            for num in to_remove {
                set.remove(&num);
            }
            if to_remove.is_empty() {
                return -1;
            }
            operations += 1;
            let mut new_set = HashSet::new();
            for &num in &set {
                new_set.insert(num - k);
            }
            set = new_set;
        }
        operations
    }
}
}