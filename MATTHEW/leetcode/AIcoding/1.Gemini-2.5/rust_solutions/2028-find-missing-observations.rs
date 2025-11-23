impl Solution {
    pub fn missing_rolls(rolls: Vec<i32>, mean: i32, n: i32) -> Vec<i32> {
        let m = rolls.len() as i64;
        let n_long = n as i64;
        let mean_long = mean as i64;

        let sum_rolls: i64 = rolls.iter().map(|&x| x as i64).sum();

        let total_sum_required = (m + n_long) * mean_long;
        let sum_missing = total_sum_required - sum_rolls;

        if sum_missing < n_long * 1 || sum_missing > n_long * 6 {
            return vec![];
        }

        let mut result = vec![0; n as usize];
        let base_val = sum_missing / n_long;
        let mut remainder = sum_missing % n_long;

        for i in 0..n as usize {
            result[i] = base_val as i32;
            if remainder > 0 {
                result[i] += 1;
                remainder -= 1;
            }
        }

        result
    }
}