use std::collections::HashMap;

struct DetectSquares {
    points: HashMap<(i32, i32), i32>,
}

impl DetectSquares {
    fn new() -> Self {
        DetectSquares {
            points: HashMap::new(),
        }
    }

    fn add(&mut self, point: Vec<i32>) {
        let (x, y) = (point[0], point[1]);
        *self.points.entry((x, y)).or_insert(0) += 1;
    }

    fn count(&self, point: Vec<i32>) -> i32 {
        let (x1, y1) = (point[0], point[1]);
        let mut res = 0;

        for (&(x2, y2), &cnt) in self.points.iter() {
            if x1 == x2 || y1 == y2 || (x1 - x2).abs() != (y1 - y2).abs() {
                continue;
            }
            let cnt_p3 = self.points.get(&(x1, y2)).unwrap_or(&0);
            let cnt_p4 = self.points.get(&(x2, y1)).unwrap_or(&0);
            res += cnt * cnt_p3 * cnt_p4;
        }

        res
    }
}