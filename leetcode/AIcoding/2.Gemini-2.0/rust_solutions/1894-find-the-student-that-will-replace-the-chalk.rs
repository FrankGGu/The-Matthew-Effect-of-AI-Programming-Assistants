impl Solution {
    pub fn chalk_replacer(chalk: Vec<i32>, k: i32) -> i32 {
        let mut sum: i64 = 0;
        for &c in &chalk {
            sum += c as i64;
        }

        let mut k_long = k as i64;
        k_long %= sum;

        for i in 0..chalk.len() {
            if k_long < chalk[i] as i64 {
                return i as i32;
            }
            k_long -= chalk[i] as i64;
        }

        0
    }
}