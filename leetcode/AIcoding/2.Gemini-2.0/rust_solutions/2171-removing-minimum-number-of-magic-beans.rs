impl Solution {
    pub fn minimum_removal(beans: Vec<i32>) -> i64 {
        let mut beans = beans;
        beans.sort();
        let n = beans.len();
        let mut total_sum: i64 = 0;
        for &bean in &beans {
            total_sum += bean as i64;
        }
        let mut min_removal = total_sum;
        for i in 0..n {
            let current_removal = total_sum - (beans[i] as i64) * (n - i) as i64;
            min_removal = min_removal.min(current_removal);
        }
        min_removal
    }
}