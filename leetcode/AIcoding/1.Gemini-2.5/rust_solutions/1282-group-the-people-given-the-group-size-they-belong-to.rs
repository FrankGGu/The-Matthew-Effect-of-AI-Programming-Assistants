use std::collections::HashMap;

impl Solution {
    pub fn group_the_people(group_sizes: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut temp_groups: HashMap<i33, Vec<i32>> = HashMap::new();

        for (person_idx, &group_size) in group_sizes.iter().enumerate() {
            let current_group_vec = temp_groups.entry(group_size).or_insert_with(Vec::new);

            current_group_vec.push(person_idx as i32);

            if current_group_vec.len() == group_size as usize {
                result.push(temp_groups.remove(&group_size).unwrap());
            }
        }

        result
    }
}