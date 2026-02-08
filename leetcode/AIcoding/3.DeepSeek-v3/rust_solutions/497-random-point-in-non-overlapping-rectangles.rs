use rand::prelude::*;

struct Solution {
    rects: Vec<Vec<i32>>,
    prefix_sum: Vec<i32>,
    rng: ThreadRng,
}

impl Solution {
    fn new(rects: Vec<Vec<i32>>) -> Self {
        let mut prefix_sum = Vec::with_capacity(rects.len());
        let mut sum = 0;
        for rect in &rects {
            let (x1, y1, x2, y2) = (rect[0], rect[1], rect[2], rect[3]);
            let area = (x2 - x1 + 1) * (y2 - y1 + 1);
            sum += area;
            prefix_sum.push(sum);
        }
        Solution {
            rects,
            prefix_sum,
            rng: thread_rng(),
        }
    }

    fn pick(&mut self) -> Vec<i32> {
        let total = *self.prefix_sum.last().unwrap();
        let mut r = self.rng.gen_range(0..total);
        let idx = match self.prefix_sum.binary_search(&r) {
            Ok(i) => i + 1,
            Err(i) => i,
        };
        r = if idx == 0 { r } else { r - self.prefix_sum[idx - 1] };
        let rect = &self.rects[idx];
        let (x1, y1, x2, _y2) = (rect[0], rect[1], rect[2], rect[3]);
        let width = x2 - x1 + 1;
        let x = x1 + r % width;
        let y = y1 + r / width;
        vec![x, y]
    }
}