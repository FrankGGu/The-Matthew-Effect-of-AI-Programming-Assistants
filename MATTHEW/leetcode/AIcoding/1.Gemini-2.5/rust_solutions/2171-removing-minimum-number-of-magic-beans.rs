impl Solution {
    pub fn minimum_removal(mut beans: Vec<i32>) -> i64 {
        let n = beans.len();
        beans.sort_unstable();

        let mut total_sum: i64 = 0;
        for &bean_count in &beans {
            total_sum += bean_count as i64;
        }

        let mut min_removed: i64 = total_sum; 

        for i in 0..n {
            let current_target_beans = beans[i] as i64;
            let num_bags_kept = (n - i) as i64;

            let current_removal_cost = total_sum - num_bags_kept * current_target_beans;

            min_removed = min_removed.min(current_removal_cost);
        }

        min_removed
    }
}