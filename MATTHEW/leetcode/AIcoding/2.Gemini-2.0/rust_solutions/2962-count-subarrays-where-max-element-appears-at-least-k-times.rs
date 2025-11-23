impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut max_val = i32::MIN;
        for &num in &nums {
            max_val = max_val.max(num);
        }

        let mut count = 0i64;
        for i in 0..n {
            let mut max_count = 0;
            for j in i..n {
                if nums[j] == max_val {
                    max_count += 1;
                }
                if max_count >= k {
                    count += (n - j) as i64;
                    break;
                }
            }
        }

        count
    }
}