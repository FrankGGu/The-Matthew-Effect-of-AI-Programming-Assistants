impl Solution {
    pub fn max_sum_range_query(nums: Vec<i32>, requests: Vec<Vec<i32>>) -> i32 {
        let n = nums.len();
        let mut freq = vec![0; n + 1];

        for req in requests {
            let start = req[0] as usize;
            let end = req[1] as usize;
            freq[start] += 1;
            if end + 1 < n {
                freq[end + 1] -= 1;
            }
        }

        for i in 1..n {
            freq[i] += freq[i - 1];
        }

        let mut freq = freq[..n].to_vec();
        freq.sort_unstable();
        let mut nums = nums;
        nums.sort_unstable();

        let mut res = 0;
        let modulo = 1_000_000_007;
        for i in 0..n {
            res = (res + nums[i] as i64 * freq[i] as i64) % modulo;
        }

        res as i32
    }
}