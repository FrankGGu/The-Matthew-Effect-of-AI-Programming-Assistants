impl Solution {
    pub fn flood_fill(image: Vec<Vec<i32>>, sr: i32, sc: i32, color: i32) -> Vec<Vec<i32>> {
        let mut image = image;
        let rows = image.len();
        let cols = image[0].len();
        let sr = sr as usize;
        let sc = sc as usize;
        let initial_color = image[sr][sc];

        if initial_color == color {
            return image;
        }

        fn dfs(image: &mut Vec<Vec<i32>>, row: usize, col: usize, initial_color: i32, color: i32) {
            if row < 0 || row >= image.len() || col < 0 || col >= image[0].len() || image[row][col] != initial_color {
                return;
            }

            image[row][col] = color;

            dfs(image, row.wrapping_sub(1), col, initial_color, color);
            dfs(image, row + 1, col, initial_color, color);
            dfs(image, row, col.wrapping_sub(1), initial_color, color);
            dfs(image, row, col + 1, initial_color, color);
        }

        dfs(&mut image, sr, sc, initial_color, color);

        image
    }
}