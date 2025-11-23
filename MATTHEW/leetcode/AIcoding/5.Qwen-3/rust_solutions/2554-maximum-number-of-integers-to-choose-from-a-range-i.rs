impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_choosable_number(upper_bound: i32, forbidden: Vec<i32>) -> i32 {
        let mut forbidden_set = std::collections::HashSet::new();
        for num in forbidden {
            forbidden_set.insert(num);
        }

        let mut dp = std::collections::HashMap::new();

        fn dfs(
            upper_bound: i32,
            forbidden: &std::collections::HashSet<i32>,
            used: i32,
            dp: &mut std::collections::HashMap<i32, i32>,
        ) -> i32 {
            if let Some(&res) = dp.get(&used) {
                return res;
            }

            let mut max_count = 0;
            for num in 1..=upper_bound {
                if (used & (1 << (num - 1))) == 0 && !forbidden.contains(&num) {
                    let new_used = used | (1 << (num - 1));
                    let count = 1 + dfs(upper_bound, forbidden, new_used, dp);
                    max_count = max_count.max(count);
                }
            }

            dp.insert(used, max_count);
            max_count
        }

        dfs(upper_bound, &forbidden_set, 0, &mut dp)
    }
}
}