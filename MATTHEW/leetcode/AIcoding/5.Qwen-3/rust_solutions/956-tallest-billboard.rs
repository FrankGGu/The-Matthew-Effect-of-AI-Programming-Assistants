impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn tallest_billboard(mut rods: Vec<i32>) -> i32 {
        let mut dp = HashMap::new();
        dp.insert(0, 0);

        for &rod in &rods {
            let mut temp = dp.clone();
            for (&diff, &max_height) in &dp {
                let new_diff = diff + rod;
                let new_max_height = max_height + rod;
                if let Some(&existing) = temp.get(&new_diff) {
                    if new_max_height > existing {
                        temp.insert(new_diff, new_max_height);
                    }
                } else {
                    temp.insert(new_diff, new_max_height);
                }

                let new_diff = diff - rod;
                let new_max_height = max_height;
                if let Some(&existing) = temp.get(&new_diff) {
                    if new_max_height > existing {
                        temp.insert(new_diff, new_max_height);
                    }
                } else {
                    temp.insert(new_diff, new_max_height);
                }
            }
            dp = temp;
        }

        dp.get(&0).copied().unwrap_or(0)
    }
}
}