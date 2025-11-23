impl Solution {
    pub fn find_key(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut freq = std::collections::HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut candidate = -1;
        let mut max_freq = 0;
        for (&num, &count) in &freq {
            if count > max_freq {
                max_freq = count;
                candidate = num;
            }
        }

        let mut result = -1;
        for i in 0..n {
            if nums[i] == candidate {
                if i > 0 && nums[i - 1] != candidate {
                    result = nums[i - 1];
                    break;
                }
                if i < n - 1 && nums[i + 1] != candidate {
                    result = nums[i + 1];
                    break;
                }
            }
        }

        result
    }
}