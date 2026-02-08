impl Solution {
    pub fn range_sum(nums: Vec<i32>, n: i32, left: i32, right: i32) -> i32 {
        let mut all_sums: Vec<i32> = Vec::new();
        let modulo: i64 = 1_000_000_007;

        for i in 0..n as usize {
            let mut current_sum: i32 = 0;
            for j in i..n as usize {
                current_sum += nums[j];
                all_sums.push(current_sum);
            }
        }

        all_sums.sort_unstable();

        let mut total_range_sum: i64 = 0;
        for k in (left - 1) as usize..(right) as usize {
            total_range_sum = (total_range_sum + all_sums[k] as i64) % modulo;
        }

        total_range_sum as i32
    }
}