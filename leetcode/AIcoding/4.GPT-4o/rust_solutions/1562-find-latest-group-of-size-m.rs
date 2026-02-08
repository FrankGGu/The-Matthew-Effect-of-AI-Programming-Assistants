impl Solution {
    pub fn find_latest_group(groups: Vec<Vec<i32>>, m: i32) -> Vec<i32> {
        let mut latest_group = Vec::new();
        let mut max_index = -1;

        for (index, group) in groups.iter().enumerate() {
            if group.len() as i32 == m {
                if index as i32 > max_index {
                    max_index = index as i32;
                    latest_group = group.clone();
                }
            }
        }

        latest_group
    }
}