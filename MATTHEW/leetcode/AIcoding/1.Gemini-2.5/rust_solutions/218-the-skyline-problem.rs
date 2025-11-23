use std::collections::BTreeMap;

impl Solution {
    pub fn get_skyline(buildings: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut events: Vec<(i32, i32)> = Vec::new();

        for building in buildings {
            let left = building[0];
            let right = building[1];
            let height = building[2];
            events.push((left, -height));
            events.push((right, height));
        }

        events.sort_unstable_by(|a, b| {
            if a.0 != b.0 {
                a.0.cmp(&b.0)
            } else {
                a.1.cmp(&b.1)
            }
        });

        let mut active_heights: BTreeMap<i32, i32> = BTreeMap::new();
        active_heights.insert(0, 1); 

        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut prev_max_height = 0;

        for (x, height_val) in events {
            if height_val < 0 {
                let h = -height_val;
                *active_heights.entry(h).or_insert(0) += 1;
            } else {
                let h = height_val;
                *active_heights.get_mut(&h).unwrap() -= 1;
                if *active_heights.get(&h).unwrap() == 0 {
                    active_heights.remove(&h);
                }
            }

            let current_max_height = *active_heights.iter().next_back().unwrap().0;

            if current_max_height != prev_max_height {
                result.push(vec![x, current_max_height]);
                prev_max_height = current_max_height;
            }
        }

        result
    }
}