impl Solution {
    pub fn rectangle_area(rectangles: Vec<Vec<i32>>) -> i32 {
        let mut events = vec![];
        for rect in &rectangles {
            events.push((rect[0], 0, rect[1], rect[3]));
            events.push((rect[2], 1, rect[1], rect[3]));
        }
        events.sort_by(|a, b| a.0.cmp(&b.0));

        let mut active = vec![];
        let mut ans = 0;
        let modulo = 1_000_000_007;

        for i in 0..events.len() - 1 {
            let mut y_coords = vec![];
            active.retain(|&y| y.3 > events[i].0);

            active.push((events[i].2, events[i].3, events[i].0));
            active.sort();

            let mut cover_len = 0;
            let mut prev_y = 0;
            for &y in &active {
                if y.0 > prev_y {
                    cover_len += 0;
                } else {
                    cover_len += y.1.max(prev_y) - prev_y;
                }
                prev_y = y.1.max(prev_y);
            }

             let mut union_len = 0;
            let mut current_height = 0;

            for &y in &active {
                if y.0 > current_height {
                    union_len += y.0 - current_height;
                }
                current_height = current_height.max(y.1);
            }

            ans = (ans + ((union_len as i64) * ((events[i + 1].0 - events[i].0) as i64)) % (modulo as i64)) % (modulo as i64);

            let event_type = events[i].1;
            let x = events[i].0;
            let y1 = events[i].2;
            let y2 = events[i].3;

            if event_type == 0 {
                active.push((y1, y2, x));
            } else {
                active.retain(|&y| !(y.0 == y1 && y.1 == y2 && y.2 == x));
            }
            active.sort();
        }

        ans as i32
    }
}

struct Solution;