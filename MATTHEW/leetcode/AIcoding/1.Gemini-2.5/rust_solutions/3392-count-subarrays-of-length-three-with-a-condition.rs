impl Solution {
    pub fn num_of_subarrays(nums: Vec<i32>, k: i32, threshold: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;

        if n < k {
            return 0;
        }

        let mut count = 0;
        let mut current_sum: i32 = 0;
        let target_sum = threshold * (k as i32);

        for i in 0..k {
            current_sum += nums[i];
        }

        if current_sum >= target_sum {
            count += 1;
        }

        for i in k..n {
            current_sum -= nums[i - k];
            current_sum += nums[i];
            if current_sum >= target_sum {
                count += 1;
            }
        }

        count
    }
}