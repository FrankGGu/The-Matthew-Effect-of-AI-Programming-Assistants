impl Solution {
    pub fn missing_rolls(rolls: Vec<i32>, mean: i32, n: i32) -> Vec<i32> {
        let m = rolls.len() as i32;
        let total = mean * (m + n);
        let sum_m: i32 = rolls.iter().sum();
        let sum_n = total - sum_m;

        if sum_n < n || sum_n > 6 * n {
            return vec![];
        }

        let mut res = vec![sum_n / n; n as usize];
        let remainder = (sum_n % n) as usize;
        for i in 0..remainder {
            res[i] += 1;
        }

        res
    }
}