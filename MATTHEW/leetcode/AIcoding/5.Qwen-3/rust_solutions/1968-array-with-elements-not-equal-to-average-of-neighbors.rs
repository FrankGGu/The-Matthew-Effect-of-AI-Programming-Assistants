impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn distinct_array_with_elements_not_equal_to_average_of_neighbors(mut nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        if n <= 2 {
            return nums;
        }

        let mut set = HashSet::new();
        for &num in &nums {
            set.insert(num);
        }

        if set.len() == 1 {
            return nums;
        }

        let mut i = 1;
        while i < n - 1 {
            let left = nums[i - 1];
            let right = nums[i + 1];
            let avg = (left + right) as f64 / 2.0;
            if nums[i] as f64 == avg {
                let mut j = i + 1;
                while j < n {
                    if nums[j] != nums[i] {
                        nums.swap(i, j);
                        break;
                    }
                    j += 1;
                }
                if j == n {
                    return nums;
                }
            }
            i += 1;
        }

        nums
    }
}
}