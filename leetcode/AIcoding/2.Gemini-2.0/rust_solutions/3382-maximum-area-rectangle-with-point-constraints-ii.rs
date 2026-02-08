use std::collections::BTreeSet;

impl Solution {
    pub fn max_area_rect(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        let mut events: Vec<(i32, i32, i32, i32)> = Vec::new();
        for i in 0..n {
            for j in i + 1..n {
                if points[i][0] < points[j][0] && points[i][1] < points[j][1] {
                    events.push((points[i][0], points[i][1], points[j][0], points[j][1]));
                } else if points[j][0] < points[i][0] && points[j][1] < points[i][1] {
                    events.push((points[j][0], points[j][1], points[i][0], points[i][1]));
                }
            }
        }

        events.sort_by(|a, b| a.2.cmp(&b.2));

        let mut ans = 0;
        for i in 0..events.len() {
            let (x1, y1, x2, y2) = events[i];
            let mut ys: BTreeSet<i32> = BTreeSet::new();
            for j in 0..n {
                if points[j][0] > x1 && points[j][0] < x2 {
                    ys.insert(points[j][1]);
                }
            }

            let mut candidates: Vec<i32> = ys.iter().cloned().collect();
            candidates.sort();

            for j in 0..i {
                let (x3, y3, x4, y4) = events[j];
                if x3 >= x1 {
                    break;
                }
                if x4 <= x1 || x3 >= x2 || y3 >= y2 {
                    continue;
                }
                let mut y_left = y3;
                let mut y_right = y4;

                for &y in &candidates {
                    if y > y_left && y < y_right && y < y2 && y > y1 {
                        ans = ans.max((x2 - x1) * (y2 - y) as i32);
                        ans = ans.max((x2 - x1) * (y - y1) as i32);
                    }
                }

            }
        }

        ans
    }
}