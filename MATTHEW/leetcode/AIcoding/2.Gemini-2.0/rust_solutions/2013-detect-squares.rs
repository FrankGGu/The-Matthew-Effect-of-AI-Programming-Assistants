use std::collections::HashMap;

struct DetectSquares {
    points: Vec<(i32, i32)>,
    count: HashMap<(i32, i32), i32>,
}

impl DetectSquares {
    fn new() -> Self {
        DetectSquares {
            points: Vec::new(),
            count: HashMap::new(),
        }
    }

    fn add(&mut self, point: Vec<i32>) {
        let x = point[0];
        let y = point[1];
        self.points.push((x, y));
        *self.count.entry((x, y)).or_insert(0) += 1;
    }

    fn count(&self, point: Vec<i32>) -> i32 {
        let x = point[0];
        let y = point[1];
        let mut ans = 0;
        for &(px, py) in &self.points {
            if px == x || py == y || (x - px).abs() != (y - py).abs() {
                continue;
            }
            let side = (x - px).abs();
            let p1 = (x, py);
            let p2 = (px, y);

            if self.count.contains_key(&p1) && self.count.contains_key(&p2) {
                ans += self.count.get(&p1).unwrap() * self.count.get(&p2).unwrap();
            }
        }
        ans
    }
}