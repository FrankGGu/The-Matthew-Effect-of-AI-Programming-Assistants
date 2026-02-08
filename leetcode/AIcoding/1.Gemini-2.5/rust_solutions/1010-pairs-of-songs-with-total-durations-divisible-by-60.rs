impl Solution {
    pub fn num_pairs_divisible_by_60(time: Vec<i32>) -> i32 {
        let mut remainder_counts = vec![0; 60]; 

        for &t in &time {
            remainder_counts[(t % 60) as usize] += 1;
        }

        let mut total_pairs: i64 = 0; 

        let count0 = remainder_counts[0] as i64;
        total_pairs += count0 * (count0 - 1) / 2;

        let count30 = remainder_counts[30] as i64;
        total_pairs += count30 * (count30 - 1) / 2;

        for i in 1..30 {
            let count_i = remainder_counts[i] as i64;
            let count_60_minus_i = remainder_counts[60 - i] as i64;
            total_pairs += count_i * count_60_minus_i;
        }

        total_pairs as i32
    }
}