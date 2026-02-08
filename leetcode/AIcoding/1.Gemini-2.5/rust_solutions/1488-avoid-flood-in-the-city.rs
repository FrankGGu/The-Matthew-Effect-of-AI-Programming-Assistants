use std::collections::{HashMap, BTreeSet};

impl Solution {
    pub fn avoid_flood(rains: Vec<i32>) -> Vec<i32> {
        let n = rains.len();
        let mut ans = vec![0; n];
        let mut last_rain_day: HashMap<i32, i32> = HashMap::new();
        let mut dry_days: BTreeSet<i32> = BTreeSet::new();

        for i in 0..n {
            let lake_id = rains[i];

            if lake_id == 0 {
                dry_days.insert(i as i32);
            } else {
                if let Some(&prev_rain_day) = last_rain_day.get(&lake_id) {
                    if let Some(&dry_day_idx) = dry_days.range(prev_rain_day + 1..).next() {
                        ans[dry_day_idx as usize] = lake_id;
                        dry_days.remove(&dry_day_idx);
                    } else {
                        return vec![];
                    }
                }
                last_rain_day.insert(lake_id, i as i32);
            }
        }

        ans
    }
}