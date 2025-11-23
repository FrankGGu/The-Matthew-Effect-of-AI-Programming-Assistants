impl Solution {
    pub fn max_sum_range_query(nums: Vec<i32>, requests: Vec<Vec<i32>>) -> i32 {
        let n = nums.len();
        let mut counts = vec![0; n];

        for req in requests {
            let start = req[0] as usize;
            let end = req[1] as usize;
            counts[start] += 1;
            if end + 1 < n {
                counts[end + 1] -= 1;
            }
        }

        for i in 1..n {
            counts[i] += counts[i - 1];
        }

        counts.sort_unstable();

        let mut sorted_nums = nums;
        sorted_nums.sort_unstable();

        let mut total_sum: i64 = 0;
        let modulo: i64 = 1_000_000_007;

        for i in 0..n {
            total_sum = (total_sum + (counts[i] as i64 * sorted_nums[i] as i64)) % modulo;
        }

        total_sum as i32
    }
}