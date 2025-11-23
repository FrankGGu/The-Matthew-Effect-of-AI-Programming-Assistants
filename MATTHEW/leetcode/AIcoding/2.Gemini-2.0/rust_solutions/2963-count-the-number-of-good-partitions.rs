use std::collections::HashMap;

impl Solution {
    pub fn number_of_good_partitions(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut last_occurrence: HashMap<i32, usize> = HashMap::new();
        for i in 0..n {
            last_occurrence.insert(nums[i], i);
        }

        let mut max_reach = 0;
        let mut partitions = 0;
        let mut current_reach = 0;

        for i in 0..n {
            current_reach = current_reach.max(*last_occurrence.get(&nums[i]).unwrap());
            if i == current_reach {
                partitions += 1;
                max_reach = i;
            }
        }

        if partitions == 0 {
            return 0;
        }

        let mod_val = 1_000_000_007;
        let mut result: i64 = 1;
        for _ in 1..(partitions) {
            result = (result * 2) % (mod_val as i64);
        }

        result as i32
    }
}