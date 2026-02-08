use rand::Rng;

struct Solution {
    rects: Vec<Vec<i32>>,
    areas: Vec<i32>,
    total_area: i32,
}

impl Solution {
    fn new(rects: Vec<Vec<i32>>) -> Self {
        let mut areas = Vec::new();
        let mut total_area = 0;
        for rect in &rects {
            let area = (rect[2] - rect[0] + 1) * (rect[3] - rect[1] + 1);
            total_area += area;
            areas.push(total_area);
        }
        Solution {
            rects,
            areas,
            total_area,
        }
    }

    fn pick(&self) -> Vec<i32> {
        let mut rng = rand::thread_rng();
        let rand_val = rng.gen_range(1..=self.total_area);
        let rect_index = self.areas.binary_search(&rand_val).unwrap_or_else(|x| x);
        let rect = &self.rects[rect_index];
        let width = rect[2] - rect[0] + 1;
        let height = rect[3] - rect[1] + 1;
        let x = rng.gen_range(0..width) + rect[0];
        let y = rng.gen_range(0..height) + rect[1];
        vec![x, y]
    }
}