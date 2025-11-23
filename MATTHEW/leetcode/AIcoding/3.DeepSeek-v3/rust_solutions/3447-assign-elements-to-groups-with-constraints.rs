use std::collections::HashSet;

impl Solution {
    pub fn group_the_people(group_sizes: Vec<i32>) -> Vec<Vec<i32>> {
        let mut size_to_indices = std::collections::HashMap::new();
        for (i, &size) in group_sizes.iter().enumerate() {
            size_to_indices.entry(size).or_insert(vec![]).push(i as i32);
        }

        let mut result = vec![];
        for (size, indices) in size_to_indices {
            for chunk in indices.chunks(size as usize) {
                result.push(chunk.to_vec());
            }
        }
        result
    }
}