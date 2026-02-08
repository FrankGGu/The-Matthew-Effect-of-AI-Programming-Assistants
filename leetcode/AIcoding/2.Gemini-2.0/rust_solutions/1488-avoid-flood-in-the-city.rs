impl Solution {
    pub fn avoid_flood(rains: Vec<i32>) -> Vec<i32> {
        let n = rains.len();
        let mut ans = vec![0; n];
        let mut full = std::collections::HashMap::new();
        let mut dry = std::collections::BTreeSet::new();

        for i in 0..n {
            if rains[i] > 0 {
                if full.contains_key(&rains[i]) {
                    return vec![-1];
                }
                full.insert(rains[i], i);
                ans[i] = -1;
            } else {
                dry.insert(i);
            }
        }

        for i in 0..n {
            if rains[i] > 0 {
                if let Some(&next_rain) = full.get(&rains[i]) {
                    if let Some(&dry_day) = dry.range(i..next_rain).next() {
                        ans[dry_day] = rains[i];
                        dry.remove(&dry_day);
                    } else {
                        if let Some(&dry_day) = dry.range(i..).next() {
                            if next_rain > dry_day {
                                return vec![-1];
                            }
                        }
                    }
                }
            }
        }

        for &day in &dry {
            ans[day] = 1;
        }

        ans
    }
}