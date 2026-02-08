impl Solution {
    pub fn max_sum_range_query(nums: Vec<i32>, requests: Vec<Vec<i32>>) -> i32 {
        let n = nums.len();
        let mut freq = vec![0; n];
        for request in &requests {
            let start = request[0] as usize;
            let end = request[1] as usize;
            freq[start] += 1;
            if end + 1 < n {
                freq[end + 1] -= 1;
            }
        }

        for i in 1..n {
            freq[i] += freq[i - 1];
        }

        let mut freq_values: Vec<i32> = freq.iter().cloned().collect();
        freq_values.sort();

        let mut nums_sorted = nums;
        nums_sorted.sort();

        let mut sum: i64 = 0;
        for i in 0..n {
            sum = (sum + (nums_sorted[i] as i64) * (freq_values[i] as i64)) % 1000000007;
        }

        sum as i32
    }
}