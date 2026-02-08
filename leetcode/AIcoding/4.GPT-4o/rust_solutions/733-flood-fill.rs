impl Solution {
    pub fn flood_fill(image: Vec<Vec<i32>>, sr: i32, sc: i32, new_color: i32) -> Vec<Vec<i32>> {
        let mut image = image;
        let original_color = image[sr as usize][sc as usize];
        if original_color == new_color {
            return image;
        }
        Self::dfs(&mut image, sr, sc, original_color, new_color);
        image
    }

    fn dfs(image: &mut Vec<Vec<i32>>, sr: i32, sc: i32, original_color: i32, new_color: i32) {
        if sr < 0 || sr >= image.len() as i32 || sc < 0 || sc >= image[0].len() as i32 {
            return;
        }
        if image[sr as usize][sc as usize] != original_color {
            return;
        }
        image[sr as usize][sc as usize] = new_color;
        Self::dfs(image, sr + 1, sc, original_color, new_color);
        Self::dfs(image, sr - 1, sc, original_color, new_color);
        Self::dfs(image, sr, sc + 1, original_color, new_color);
        Self::dfs(image, sr, sc - 1, original_color, new_color);
    }
}