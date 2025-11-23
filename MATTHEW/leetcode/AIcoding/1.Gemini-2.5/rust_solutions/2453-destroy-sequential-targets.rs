use std::collections::HashMap;

impl Solution {
    pub fn destroy_targets(nums: Vec<i32>, space: i32) -> i32 {
        let mut remainder_counts: HashMap<i32, i32> = HashMap::new();

        for &num in &nums {
            *remainder_counts.entry(num % space).or_insert(0) += 1;
        }

        let mut max_count = 0;
        for &count in remainder_counts.values() {
            if count > max_count {
                max_count = count;
            }
        }

        let mut min_start_num = i32::MAX;

        for &num in &nums {
            let remainder = num % space;
            if let Some(&count) = remainder_counts.get(&remainder) {
                if count == max_count {
                    if num < min_start_num {
                        min_start_num = num;
                    }
                }
            }
        }

        min_start_num
    }
}