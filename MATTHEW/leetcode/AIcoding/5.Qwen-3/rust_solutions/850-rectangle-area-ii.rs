impl Solution {

use std::collections::BTreeSet;

impl Solution {
    pub fn rectangle_area(rects: Vec<Vec<i32>>) -> i32 {
        let mut events = Vec::new();
        for rect in rects {
            let x1 = rect[0];
            let y1 = rect[1];
            let x2 = rect[2];
            let y2 = rect[3];
            events.push((x1, y1, y2, 1));
            events.push((x2, y1, y2, -1));
        }
        events.sort_by(|a, b| {
            if a.0 != b.0 {
                a.0.cmp(&b.0)
            } else {
                a.3.cmp(&b.3)
            }
        });
        let mut prev_x = 0;
        let mut active = BTreeSet::new();
        let mut total_area = 0;
        for event in events {
            let x = event.0;
            let y1 = event.1;
            let y2 = event.2;
            let delta = event.3;
            if x != prev_x && !active.is_empty() {
                let height: i32 = active.iter().map(|&(y1, y2)| y2 - y1).sum();
                total_area += (x - prev_x) * height;
            }
            if delta == 1 {
                active.insert((y1, y2));
            } else {
                active.remove(&(y1, y2));
            }
            prev_x = x;
        }
        total_area
    }
}

struct Solution;
}