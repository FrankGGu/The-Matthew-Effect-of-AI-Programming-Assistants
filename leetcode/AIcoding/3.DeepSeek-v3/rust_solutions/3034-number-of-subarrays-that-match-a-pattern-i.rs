impl Solution {
    pub fn count_matching_subarrays(nums: Vec<i32>, pattern: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = pattern.len();
        if n <= m {
            return 0;
        }

        let mut count = 0;
        for i in 0..n - m {
            let mut matched = true;
            for k in 0..m {
                let expected = pattern[k];
                let actual = match nums[i + k + 1].cmp(&nums[i + k]) {
                    std::cmp::Ordering::Less => -1,
                    std::cmp::Ordering::Equal => 0,
                    std::cmp::Ordering::Greater => 1,
                };
                if actual != expected {
                    matched = false;
                    break;
                }
            }
            if matched {
                count += 1;
            }
        }
        count
    }
}