impl Solution {
    pub fn minimum_removal(beans: Vec<i32>) -> i64 {
        let mut beans = beans;
        beans.sort_unstable();
        let total: i64 = beans.iter().map(|&x| x as i64).sum();
        let n = beans.len();
        let mut min_beans = i64::MAX;

        for i in 0..n {
            let current = total - (beans[i] as i64) * (n - i) as i64;
            if current < min_beans {
                min_beans = current;
            }
        }

        min_beans
    }
}