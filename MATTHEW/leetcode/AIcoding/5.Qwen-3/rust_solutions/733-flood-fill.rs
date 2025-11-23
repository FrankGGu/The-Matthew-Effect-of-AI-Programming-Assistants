impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn flood_fill(
        image: Vec<Vec<i32>>,
        sr: i32,
        sc: i32,
        new_color: i32,
    ) -> Vec<Vec<i32>> {
        let rows = image.len();
        let cols = image[0].len();
        let original_color = image[sr as usize][sc as usize];
        if original_color == new_color {
            return image;
        }

        let mut image = image;
        let mut queue = VecDeque::new();
        queue.push_back((sr, sc));
        image[sr as usize][sc as usize] = new_color;

        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        while let Some((r, c)) = queue.pop_front() {
            for &(dr, dc) in &directions {
                let nr = r + dr;
                let nc = c + dc;
                if nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                    if image[nr as usize][nc as usize] == original_color {
                        image[nr as usize][nc as usize] = new_color;
                        queue.push_back((nr, nc));
                    }
                }
            }
        }

        image
    }
}
}