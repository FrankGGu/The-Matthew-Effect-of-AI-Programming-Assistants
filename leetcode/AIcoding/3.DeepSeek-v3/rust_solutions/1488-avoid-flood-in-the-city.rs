use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn avoid_flood(rains: Vec<i32>) -> Vec<i32> {
        let mut lake_to_days = HashMap::new();
        let mut dry_days = vec![];
        let mut result = vec![-1; rains.len()];

        for (day, &lake) in rains.iter().enumerate() {
            if lake == 0 {
                dry_days.push(day);
                continue;
            }

            if let Some(&prev_day) = lake_to_days.get(&lake) {
                let mut found = false;
                for i in 0..dry_days.len() {
                    if dry_days[i] > prev_day {
                        result[dry_days[i]] = lake;
                        dry_days.remove(i);
                        found = true;
                        break;
                    }
                }
                if !found {
                    return vec![];
                }
            }
            lake_to_days.insert(lake, day);
        }

        for &day in &dry_days {
            result[day] = 1;
        }

        result
    }
}