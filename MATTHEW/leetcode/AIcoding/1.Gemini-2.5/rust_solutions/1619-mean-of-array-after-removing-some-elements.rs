impl Solution {
    pub fn trim_mean(mut nums: Vec<i32>) -> f64 {
        nums.sort_unstable();
        let n = nums.len();
        let elements_to_remove = n / 20; // 5% of elements

        let mut sum: i64 = 0;
        let mut count: i64 = 0;

        for i in elements_to_remove..(n - elements_to_remove) {
            sum += nums[i] as i64;
            count += 1;
        }

        sum as f64 / count as f64
    }
}