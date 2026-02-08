impl Solution {
    pub fn pacific_atlantic(heights: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = heights.len();
        let n = heights[0].len();
        let mut pacific = vec![vec![false; n]; m];
        let mut atlantic = vec![vec![false; n]; m];

        fn dfs(
            heights: &Vec<Vec<i32>>,
            visited: &mut Vec<Vec<bool>>,
            i: usize,
            j: usize,
            prev_height: i32,
        ) {
            if i >= heights.len() || j >= heights[0].len() || visited[i][j] || heights[i][j] < prev_height {
                return;
            }

            visited[i][j] = true;
            dfs(heights, visited, i + 1, j, heights[i][j]);
            dfs(heights, visited, i - 1, j, heights[i][j]);
            dfs(heights, visited, i, j + 1, heights[i][j]);
            dfs(heights, visited, i, j - 1, heights[i][j]);
        }

        for i in 0..m {
            dfs(&heights, &mut pacific, i, 0, i32::MIN);
            dfs(&heights, &mut atlantic, i, n - 1, i32::MIN);
        }

        for j in 0..n {
            dfs(&heights, &mut pacific, 0, j, i32::MIN);
            dfs(&heights, &mut atlantic, m - 1, j, i32::MIN);
        }

        let mut result = Vec::new();
        for i in 0..m {
            for j in 0..n {
                if pacific[i][j] && atlantic[i][j] {
                    result.push(vec![i as i32, j as i32]);
                }
            }
        }

        result
    }
}