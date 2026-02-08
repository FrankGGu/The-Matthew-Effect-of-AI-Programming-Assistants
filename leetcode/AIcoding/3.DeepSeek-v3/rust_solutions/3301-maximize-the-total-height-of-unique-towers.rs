use std::collections::HashSet;

impl Solution {
    pub fn maximize_tower_height_sum(boxes: Vec<Vec<i32>>) -> i32 {
        let mut boxes = boxes;
        boxes.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                b[1].cmp(&a[1])
            }
        });

        let mut dp = Vec::new();
        let mut res = 0;

        for box_ in boxes {
            let (w, h) = (box_[0], box_[1]);
            let idx = dp.partition_point(|&x| x < h);
            if idx == dp.len() {
                dp.push(h);
            } else {
                dp[idx] = h;
            }
            res = res.max(dp.iter().sum());
        }

        res
    }
}