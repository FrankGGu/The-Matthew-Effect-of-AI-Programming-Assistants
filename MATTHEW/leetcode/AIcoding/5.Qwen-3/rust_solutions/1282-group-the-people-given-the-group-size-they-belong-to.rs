impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn group_the_people(mut group_sizes: Vec<i32>) -> Vec<Vec<i32>> {
        let mut groups = HashMap::new();
        let mut result = Vec::new();

        for (i, &size) in group_sizes.iter().enumerate() {
            let key = size;
            let group = groups.entry(key).or_insert_with(Vec::new);
            group.push(i as i32);

            if group.len() == key as usize {
                result.push(group.clone());
                group.clear();
            }
        }

        result
    }
}
}