impl Solution {
    pub fn find_max_k_sum(nums: Vec<i32>, k: i32) -> i64 {
        let k = k as usize;
        if nums.len() < k {
            return 0;
        }

        let mut current_sum: i64 = nums[0..k].iter().map(|&x| x as i64).sum();
        let mut max_sum: i64 = current_sum;

        for i in k..nums.len() {
            current_sum -= nums[i - k] as i64;
            current_sum += nums[i] as i64;
            max_sum = max_sum.max(current_sum);
        }

        max_sum
    }
}