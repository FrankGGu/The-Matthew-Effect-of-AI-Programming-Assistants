impl Solution {
    pub fn pacific_atlantic(heights: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        if heights.is_empty() {
            return vec![];
        }
        let rows = heights.len();
        let cols = heights[0].len();
        let mut pacific = vec![vec![false; cols]; rows];
        let mut atlantic = vec![vec![false; cols]; rows];

        for i in 0..rows {
            Self::dfs(&heights, &mut pacific, i, 0, i32::MIN);
            Self::dfs(&heights, &mut atlantic, i, cols - 1, i32::MIN);
        }

        for j in 0..cols {
            Self::dfs(&heights, &mut pacific, 0, j, i32::MIN);
            Self::dfs(&heights, &mut atlantic, rows - 1, j, i32::MIN);
        }

        let mut result = Vec::new();
        for i in 0..rows {
            for j in 0..cols {
                if pacific[i][j] && atlantic[i][j] {
                    result.push(vec![i as i32, j as i32]);
                }
            }
        }
        result
    }

    fn dfs(heights: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, i: usize, j: usize, prev_height: i32) {
        if i >= heights.len() || j >= heights[0].len() || visited[i][j] || heights[i][j] < prev_height {
            return;
        }
        visited[i][j] = true;
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        for (di, dj) in directions.iter() {
            let ni = i as i32 + di;
            let nj = j as i32 + dj;
            if ni >= 0 && nj >= 0 {
                Self::dfs(heights, visited, ni as usize, nj as usize, heights[i][j]);
            }
        }
    }
}