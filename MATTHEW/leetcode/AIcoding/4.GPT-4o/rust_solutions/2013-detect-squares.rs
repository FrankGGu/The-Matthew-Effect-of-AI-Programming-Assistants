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
        let count = self.points.entry((point[0], point[1])).or_insert(0);
        *count += 1;
    }

    fn count(&self, point: Vec<i32>) -> i32 {
        let (x, y) = (point[0], point[1]);
        let mut result = 0;

        for (&(px, py), &count) in &self.points {
            if px == x || py == y {
                continue;
            }
            let d = (px - x).abs();
            if d != (py - y).abs() {
                continue;
            }
            if let Some(&count2) = self.points.get(&(x, py)) {
                result += count * count2;
            }
            if let Some(&count3) = self.points.get(&(px, y)) {
                result += count * count3;
            }
        }

        result
    }
}