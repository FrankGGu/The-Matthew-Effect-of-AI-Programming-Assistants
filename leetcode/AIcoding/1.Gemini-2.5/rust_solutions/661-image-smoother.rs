impl Solution {
    pub fn image_smoother(img: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let rows = img.len();
        let cols = img[0].len();
        let mut smoothed_img = vec![vec![0; cols]; rows];

        for r in 0..rows {
            for c in 0..cols {
                let mut sum = 0;
                let mut count = 0;

                for dr in -1..=1 {
                    for dc in -1..=1 {
                        let nr = r as isize + dr;
                        let nc = c as isize + dc;

                        if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize {
                            sum += img[nr as usize][nc as usize];
                            count += 1;
                        }
                    }
                }
                smoothed_img[r][c] = sum / count;
            }
        }

        smoothed_img
    }
}