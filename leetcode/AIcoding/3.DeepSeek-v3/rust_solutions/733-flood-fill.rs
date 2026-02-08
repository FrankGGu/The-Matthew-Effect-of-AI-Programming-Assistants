impl Solution {
    pub fn flood_fill(image: Vec<Vec<i32>>, sr: i32, sc: i32, new_color: i32) -> Vec<Vec<i32>> {
        let mut image = image;
        let (m, n) = (image.len(), image[0].len());
        let (sr, sc) = (sr as usize, sc as usize);
        let old_color = image[sr][sc];
        if old_color == new_color {
            return image;
        }
        let mut stack = vec![(sr, sc)];
        while let Some((r, c)) = stack.pop() {
            if image[r][c] == old_color {
                image[r][c] = new_color;
                if r > 0 {
                    stack.push((r - 1, c));
                }
                if r < m - 1 {
                    stack.push((r + 1, c));
                }
                if c > 0 {
                    stack.push((r, c - 1));
                }
                if c < n - 1 {
                    stack.push((r, c + 1));
                }
            }
        }
        image
    }
}