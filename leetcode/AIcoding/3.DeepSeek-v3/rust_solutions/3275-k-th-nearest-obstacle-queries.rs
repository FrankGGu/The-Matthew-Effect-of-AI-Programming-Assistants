use std::collections::BTreeSet;

impl Solution {
    pub fn k_nearest_obstacles(obstacles: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut x_map = std::collections::BTreeMap::new();
        let mut y_map = std::collections::BTreeMap::new();

        for obstacle in obstacles {
            let (x, y) = (obstacle[0], obstacle[1]);
            x_map.entry(x).or_insert(BTreeSet::new()).insert(y);
            y_map.entry(y).or_insert(BTreeSet::new()).insert(x);
        }

        queries.into_iter().map(|query| {
            let (x, y, k) = (query[0], query[1], query[2]);
            let mut min_dist = i32::MAX;
            let mut res = -1;

            if let Some(ys) = x_map.get(&x) {
                if let Some(&y_ob) = ys.range(y..).next() {
                    let dist = y_ob - y;
                    if dist < min_dist {
                        min_dist = dist;
                        res = x * x + y_ob * y_ob;
                    }
                }
                if let Some(&y_ob) = ys.range(..=y).next_back() {
                    let dist = y - y_ob;
                    if dist < min_dist || (dist == min_dist && x * x + y_ob * y_ob < res) {
                        min_dist = dist;
                        res = x * x + y_ob * y_ob;
                    }
                }
            }

            if let Some(xs) = y_map.get(&y) {
                if let Some(&x_ob) = xs.range(x..).next() {
                    let dist = x_ob - x;
                    if dist < min_dist || (dist == min_dist && x_ob * x_ob + y * y < res) {
                        min_dist = dist;
                        res = x_ob * x_ob + y * y;
                    }
                }
                if let Some(&x_ob) = xs.range(..=x).next_back() {
                    let dist = x - x_ob;
                    if dist < min_dist || (dist == min_dist && x_ob * x_ob + y * y < res) {
                        min_dist = dist;
                        res = x_ob * x_ob + y * y;
                    }
                }
            }

            res
        }).collect()
    }
}