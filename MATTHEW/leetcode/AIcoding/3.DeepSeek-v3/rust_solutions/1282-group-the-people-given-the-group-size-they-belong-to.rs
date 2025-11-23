use std::collections::HashMap;

impl Solution {
    pub fn group_the_people(group_sizes: Vec<i32>) -> Vec<Vec<i32>> {
        let mut groups = HashMap::new();
        let mut result = Vec::new();

        for (i, &size) in group_sizes.iter().enumerate() {
            let entry = groups.entry(size).or_insert(Vec::new());
            entry.push(i as i32);
            if entry.len() == size as usize {
                result.push(entry.clone());
                groups.remove(&size);
            }
        }

        result
    }
}