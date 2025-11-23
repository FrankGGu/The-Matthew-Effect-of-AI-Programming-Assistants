use rand::Rng;

struct Solution {
    rectangles: Vec<Vec<i32>>,
    total_area: i32,
}

impl Solution {
    fn new(rectangles: Vec<Vec<i32>>) -> Self {
        let total_area = rectangles.iter().map(|r| (r[2] - r[0]) * (r[3] - r[1])).sum();
        Solution { rectangles, total_area }
    }

    fn pick(&self) -> Vec<i32> {
        let mut rng = rand::thread_rng();
        let mut area = rng.gen_range(0..self.total_area);

        for rect in &self.rectangles {
            let rect_area = (rect[2] - rect[0]) * (rect[3] - rect[1]);
            if area < rect_area {
                return vec![
                    rect[0] + rng.gen_range(0..(rect[2] - rect[0])),
                    rect[1] + rng.gen_range(0..(rect[3] - rect[1])),
                ];
            }
            area -= rect_area;
        }
        vec![]
    }
}