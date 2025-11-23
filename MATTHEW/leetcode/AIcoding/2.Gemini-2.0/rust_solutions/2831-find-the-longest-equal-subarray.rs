impl Solution {
    pub fn find_longest_equal_subarray(nums: Vec<i32>, k: i32) -> i32 {
        let mut max_len = 0;
        for i in 0..nums.len() {
            for j in i..nums.len() {
                let mut count = 0;
                let mut diff = 0;
                for l in i..=j {
                    if nums[l] == nums[i] {
                        count += 1;
                    } else {
                        diff += 1;
                    }
                }
                if diff <= k {
                    max_len = max_len.max(count);
                }
            }
        }
        max_len
    }
}