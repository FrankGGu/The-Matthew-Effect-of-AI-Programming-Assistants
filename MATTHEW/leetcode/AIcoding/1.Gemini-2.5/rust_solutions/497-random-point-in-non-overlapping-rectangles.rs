use rand::Rng;
use rand::thread_rng;

struct Solution {
    rects: Vec<Vec<i32>>,
    prefix_sums: Vec<i64>,
    rng: rand::rngs::ThreadRng,
}

impl Solution {
    fn new(rects: Vec<Vec<i32>>) -> Self {
        let mut prefix_sums = Vec::new();
        let mut current_total_points: i64 = 0;

        for rect in &rects {
            let x1 = rect[0] as i64;
            let y1 = rect[1] as i64;
            let x2 = rect[2] as i64;
            let y2 = rect[3] as i64;

            let width = x2 - x1 + 1;
            let height = y2 - y1 + 1;
            let points_in_rect = width * height;

            current_total_points += points_in_rect;
            prefix_sums.push(current_total_points);
        }

        Solution {
            rects,
            prefix_sums,
            rng: thread_rng(),
        }
    }

    fn pick(&mut self) -> Vec<i32> {
        let total_points = *self.prefix_sums.last().unwrap();

        let target_point_index = self.rng.gen_range(0..total_points);

        let rect_idx = self.prefix_sums.partition_point(|&x| x <= target_point_index);

        let rect = &self.rects[rect_idx];
        let x1 = rect[0] as i64;
        let y1 = rect[1] as i64;
        let x2 = rect[2] as i64;
        let y2 = rect[3] as i64;

        let points_before_this_rect = if rect_idx > 0 {
            self.prefix_sums[rect_idx - 1]
        } else {
            0
        };

        let relative_point_index = target_point_index - points_before_this_rect;

        let width = x2 - x1 + 1;

        let x_offset = relative_point_index % width;
        let y_offset = relative_point_index / width;

        let x = x1 + x_offset;
        let y = y1 + y_offset;

        vec![x as i32, y as i32]
    }
}