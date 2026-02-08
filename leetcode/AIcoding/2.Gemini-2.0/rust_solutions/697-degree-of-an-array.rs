use std::collections::HashMap;

impl Solution {
    pub fn find_shortest_sub_array(nums: Vec<i32>) -> i32 {
        let mut left = HashMap::new();
        let mut right = HashMap::new();
        let mut count = HashMap::new();

        for i in 0..nums.len() {
            let num = nums[i];
            if !left.contains_key(&num) {
                left.insert(num, i as i32);
            }
            right.insert(num, i as i32);
            *count.entry(num).or_insert(0) += 1;
        }

        let mut degree = 0;
        for &val in count.values() {
            degree = degree.max(val);
        }

        let mut ans = nums.len() as i32;
        for (&key, &val) in &count {
            if val == degree {
                ans = ans.min(right[&key] - left[&key] + 1);
            }
        }

        ans
    }
}