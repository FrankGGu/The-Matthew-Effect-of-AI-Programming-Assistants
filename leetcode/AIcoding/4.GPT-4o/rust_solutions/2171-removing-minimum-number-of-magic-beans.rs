impl Solution {
    pub fn min_beans(mut beans: Vec<i32>) -> i32 {
        let total: i32 = beans.iter().sum();
        let n = beans.len() as i32;
        beans.sort();
        let mut min_removal = i32::MAX;

        for (i, &bean) in beans.iter().enumerate() {
            let removed = total - bean * (n - i);
            min_removal = min_removal.min(removed);
        }

        min_removal
    }
}