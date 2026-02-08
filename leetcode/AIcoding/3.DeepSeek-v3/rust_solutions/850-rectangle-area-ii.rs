use std::collections::BTreeSet;

impl Solution {
    pub fn rectangle_area(rectangles: Vec<Vec<i32>>) -> i32 {
        let mut events = Vec::new();
        let mut x_set = BTreeSet::new();

        for rect in rectangles.iter() {
            let (x1, y1, x2, y2) = (rect[0], rect[1], rect[2], rect[3]);
            events.push((y1, x1, x2, 1));
            events.push((y2, x1, x2, -1));
            x_set.insert(x1);
            x_set.insert(x2);
        }

        events.sort();
        let x_list: Vec<_> = x_set.into_iter().collect();
        let mut x_index = std::collections::HashMap::new();
        for (i, &x) in x_list.iter().enumerate() {
            x_index.insert(x, i);
        }

        let mut active = vec![0; x_list.len()];
        let mut res: i64 = 0;
        let mut prev_y = 0;
        let mut current_x_sum = 0;

        for event in events {
            let (y, x1, x2, delta) = event;
            res += current_x_sum * (y as i64 - prev_y as i64);
            let i1 = x_index[&x1];
            let i2 = x_index[&x2];
            for i in i1..i2 {
                active[i] += delta;
            }
            current_x_sum = 0;
            for i in 0..x_list.len() - 1 {
                if active[i] > 0 {
                    current_x_sum += (x_list[i + 1] as i64 - x_list[i] as i64);
                }
            }
            prev_y = y;
        }

        (res % 1_000_000_007) as i32
    }
}