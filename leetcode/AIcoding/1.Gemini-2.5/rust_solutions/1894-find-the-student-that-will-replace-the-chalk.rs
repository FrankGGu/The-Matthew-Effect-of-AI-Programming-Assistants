impl Solution {
    pub fn chalk_replacement(chalk: Vec<i32>, k: i32) -> i32 {
        let mut k_long = k as i64;
        let mut sum_chalk: i64 = 0;
        for &c in chalk.iter() {
            sum_chalk += c as i64;
        }

        k_long %= sum_chalk;

        for i in 0..chalk.len() {
            let current_chalk_needed = chalk[i] as i64;
            if k_long < current_chalk_needed {
                return i as i32;
            }
            k_long -= current_chalk_needed;
        }

        unreachable!()
    }
}