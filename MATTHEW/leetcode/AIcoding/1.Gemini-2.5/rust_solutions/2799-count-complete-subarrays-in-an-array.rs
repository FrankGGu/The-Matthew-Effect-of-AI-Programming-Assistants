use std::collections::HashMap;
use std::collections::HashSet;

impl Solution {
    pub fn count_complete_subarrays(nums: Vec<i32>) -> i64 {
        let n = nums.len();

        let mut distinct_elements_in_array: HashSet<i32> = HashSet::new();
        for &num in nums.iter() {
            distinct_elements_in_array.insert(num);
        }
        let k_total = distinct_elements_in_array.len();

        if k_total == 0 {
            return 0;
        }

        let mut count: i64 = 0;
        let mut left = 0;
        let mut window_freq: HashMap<i32, i32> = HashMap::new();
        let mut distinct_in_window = 0;

        for right in 0..n {
            let num_right = nums[right];
            *window_freq.entry(num_right).or_insert(0) += 1;
            if *window_freq.get(&num_right).unwrap() == 1 {
                distinct_in_window += 1;
            }

            while distinct_in_window == k_total {
                count += (n - right) as i64;

                let num_left = nums[left];
                *window_freq.get_mut(&num_left).unwrap() -= 1;
                if *window_freq.get(&num_left).unwrap() == 0 {
                    distinct_in_window -= 1;
                }
                left += 1;
            }
        }

        count
    }
}