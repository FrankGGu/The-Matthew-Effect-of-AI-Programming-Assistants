impl Solution {
    pub fn missing_rolls(rolls: Vec<i32>, mean: i32, n: i32) -> Vec<i32> {
        let m = rolls.len() as i32;
        let sum: i32 = rolls.iter().sum();
        let missing_sum = mean * (n + m) - sum;

        if missing_sum < n || missing_sum > 6 * n {
            return vec![];
        }

        let base = missing_sum / n;
        let remainder = missing_sum % n;

        let mut result = vec![base; n as usize];
        for i in 0..remainder {
            result[i as usize] += 1;
        }

        result
    }
}