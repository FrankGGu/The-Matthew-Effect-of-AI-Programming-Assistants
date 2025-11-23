impl Solution {
    pub fn field_of_greatest_blessing(force_field: Vec<Vec<i32>>) -> i32 {
        let mut events = Vec::new();
        for field in &force_field {
            let (x, y, side) = (field[0], field[1], field[2]);
            let x1 = x as f64 - side as f64 / 2.0;
            let x2 = x as f64 + side as f64 / 2.0;
            let y1 = y as f64 - side as f64 / 2.0;
            let y2 = y as f64 + side as f64 / 2.0;
            events.push((y1, 1, x1, x2));
            events.push((y2, -1, x1, x2));
        }
        events.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap());

        let mut active = Vec::new();
        let mut res = 0;
        let mut i = 0;
        while i < events.len() {
            let y = events[i].0;
            let mut j = i;
            while j < events.len() && events[j].0 == y {
                let (_, delta, x1, x2) = events[j];
                if delta == 1 {
                    active.push((x1, x2));
                } else {
                    if let Some(pos) = active.iter().position(|&(a, b)| a == x1 && b == x2) {
                        active.remove(pos);
                    }
                }
                j += 1;
            }
            i = j;

            active.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap());
            let mut xs = Vec::new();
            for &(x1, x2) in &active {
                xs.push((x1, 1));
                xs.push((x2, -1));
            }
            xs.sort_by(|a, b| a.0.partial_cmp(&b.0).unwrap());

            let mut cnt = 0;
            let mut max_cnt = 0;
            for (x, delta) in xs {
                cnt += delta;
                if cnt > max_cnt {
                    max_cnt = cnt;
                }
            }
            if max_cnt > res {
                res = max_cnt;
            }
        }
        res
    }
}