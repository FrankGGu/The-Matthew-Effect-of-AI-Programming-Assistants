impl Solution {
    pub fn longest_unequal_adjacent_groups_subsequence(groups: Vec<i32>) -> Vec<i32> {
        if groups.is_empty() {
            return Vec::new();
        }

        let mut result = Vec::new();
        result.push(0);
        let mut last_group = groups[0];

        for i in 1..groups.len() {
            if groups[i] != last_group {
                result.push(i as i32);
                last_group = groups[i];
            }
        }

        result
    }
}