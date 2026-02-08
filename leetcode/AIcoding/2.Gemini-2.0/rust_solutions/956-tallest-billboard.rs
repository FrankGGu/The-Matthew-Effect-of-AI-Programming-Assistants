use std::collections::HashMap;

impl Solution {
    pub fn tallest_billboard(rods: Vec<i32>) -> i32 {
        let n = rods.len();
        let mut dp: HashMap<i32, i32> = HashMap::new();
        dp.insert(0, 0);

        for &rod in &rods {
            let mut new_dp: HashMap<i32, i32> = dp.clone();
            for (&diff, &height) in &dp {
                let new_height1 = new_dp.entry(diff + rod).or_insert(0);
                *new_height1 = (*new_height1).max(height);

                let new_height2 = new_dp.entry((diff - rod)).or_insert(0);
                *new_height2 = (*new_height2).max(height + rod.min(diff.abs()));
            }
            dp = new_dp;
        }

        *dp.get(&0).unwrap_or(&0)
    }
}