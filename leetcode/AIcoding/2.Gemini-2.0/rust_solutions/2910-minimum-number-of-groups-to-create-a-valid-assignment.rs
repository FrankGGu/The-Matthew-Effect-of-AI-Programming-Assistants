use std::collections::HashMap;

impl Solution {
    pub fn min_groups_for_valid_assignment(nums: Vec<i32>) -> i32 {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut min_count = i32::MAX;
        for &count in counts.values() {
            min_count = min_count.min(count);
        }

        for group_size in (1..=min_count).rev() {
            let mut possible = true;
            let mut groups = 0;
            for &count in counts.values() {
                let num_groups = count / (group_size + 1);
                let remainder = count % (group_size + 1);

                if remainder > num_groups * group_size {
                    possible = false;
                    break;
                }

                groups += (count + group_size) / (group_size + 1);
            }

            if possible {
                return groups;
            }
        }

        nums.len() as i32
    }
}