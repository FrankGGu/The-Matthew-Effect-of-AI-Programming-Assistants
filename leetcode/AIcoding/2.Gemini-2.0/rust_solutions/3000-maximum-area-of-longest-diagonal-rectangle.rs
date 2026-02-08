impl Solution {
    pub fn area_of_max_diagonal(rectangles: Vec<Vec<i32>>) -> i32 {
        let mut max_diagonal = 0.0;
        let mut max_area = 0;

        for rect in rectangles {
            let l = rect[0];
            let w = rect[1];
            let diagonal = (l as f64 * l as f64 + w as f64 * w as f64).sqrt();

            if diagonal > max_diagonal {
                max_diagonal = diagonal;
                max_area = l * w;
            } else if diagonal == max_diagonal {
                max_area = max_area.max(l * w);
            }
        }

        max_area
    }
}