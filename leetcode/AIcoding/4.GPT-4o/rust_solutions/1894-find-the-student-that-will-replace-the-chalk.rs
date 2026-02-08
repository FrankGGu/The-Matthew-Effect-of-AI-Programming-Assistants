pub fn chalk_replacer(chalk: Vec<i32>, k: i32) -> i32 {
    let total_chalk: i32 = chalk.iter().sum();
    let k = k % total_chalk;
    let mut sum = 0;

    for (i, &c) in chalk.iter().enumerate() {
        sum += c;
        if sum > k {
            return i as i32;
        }
    }
    0
}