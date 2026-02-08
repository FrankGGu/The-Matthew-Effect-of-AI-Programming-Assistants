impl Solution {
    pub fn count_alternating_subarrays(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut count = 0;
        for i in 0..n {
            for j in i + 1..n {
                let mut alternating = true;
                for k in i..j {
                    if nums[k] == nums[k + 1] {
                        alternating = false;
                        break;
                    }
                }
                if alternating {
                    count += 1;
                }
            }
        }
        count as i64
    }
}