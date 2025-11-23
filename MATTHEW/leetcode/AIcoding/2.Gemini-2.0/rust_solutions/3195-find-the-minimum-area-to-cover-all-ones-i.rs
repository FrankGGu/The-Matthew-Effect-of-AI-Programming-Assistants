impl Solution {
    pub fn min_area_rect(image: Vec<String>, x: i32, y: i32) -> i32 {
        let (m, n) = (image.len(), image[0].len());
        let mut min_x = n as i32;
        let mut max_x = -1;
        let mut min_y = m as i32;
        let mut max_y = -1;

        for i in 0..m {
            for j in 0..n {
                if image[i].chars().nth(j).unwrap() == '1' {
                    min_x = min_x.min(j as i32);
                    max_x = max_x.max(j as i32);
                    min_y = min_y.min(i as i32);
                    max_y = max_y.max(i as i32);
                }
            }
        }

        (max_x - min_x + 1) * (max_y - min_y + 1)
    }
}