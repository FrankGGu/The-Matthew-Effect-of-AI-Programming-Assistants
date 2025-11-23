impl Solution {
    pub fn flood_fill(mut image: Vec<Vec<i32>>, sr: i32, sc: i32, new_color: i32) -> Vec<Vec<i32>> {
        let rows = image.len() as i32;
        if rows == 0 {
            return image;
        }
        let cols = image[0].len() as i32;

        let start_color = image[sr as usize][sc as usize];

        if start_color == new_color {
            return image;
        }

        Self::dfs(&mut image, rows, cols, sr, sc, start_color, new_color);

        image
    }

    fn dfs(
        image: &mut Vec<Vec<i32>>,
        rows: i32,
        cols: i32,
        r: i32,
        c: i32,
        start_color: i32,
        new_color: i32,
    ) {
        if r < 0 || r >= rows || c < 0 || c >= cols {
            return;
        }

        if image[r as usize][c as usize] != start_color {
            return;
        }

        image[r as usize][c as usize] = new_color;

        Self::dfs(image, rows, cols, r + 1, c, start_color, new_color);
        Self::dfs(image, rows, cols, r - 1, c, start_color, new_color);
        Self::dfs(image, rows, cols, r, c + 1, start_color, new_color);
        Self::dfs(image, rows, cols, r, c - 1, start_color, new_color);
    }
}