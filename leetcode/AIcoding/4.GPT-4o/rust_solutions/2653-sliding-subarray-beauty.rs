use std::collections::BTreeMap;

impl Solution {
    pub fn get_subarray_beauty(nums: Vec<i32>, k: i32, x: i32) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n - k as usize + 1];
        let mut count = BTreeMap::new();

        for i in 0..k as usize {
            *count.entry(nums[i]).or_insert(0) += 1;
        }

        for i in 0..=n - k as usize {
            if i > 0 {
                *count.entry(nums[i + k as usize - 1]).or_insert(0) += 1;
                let entry = count.entry(nums[i - 1]).or_insert(0);
                *entry -= 1;
                if *entry == 0 {
                    count.remove(&nums[i - 1]);
                }
            }
            let mut beauty = 0;
            let mut less_than_x = 0;
            for (&num, &c) in &count {
                if num < x {
                    less_than_x += c;
                    beauty += num * c;
                }
            }
            if less_than_x < x {
                result[i] = beauty as i32;
            } else {
                result[i] = 0;
            }
        }
        result
    }
}