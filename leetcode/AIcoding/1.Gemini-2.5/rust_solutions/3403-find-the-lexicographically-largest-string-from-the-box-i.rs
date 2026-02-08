impl Solution {
    pub fn find_lexicographically_largest_string(box_vec: Vec<String>) -> String {
        let rows = box_vec.len();
        if rows == 0 {
            return String::new();
        }
        let cols = box_vec[0].len();
        if cols == 0 {
            return String::new();
        }

        let mut grid: Vec<Vec<char>> = box_vec.into_iter()
            .map(|s| s.chars().collect())
            .collect();

        for c in 0..cols {
            let mut column_chars: Vec<char> = Vec::new();
            for r in 0..rows {
                if grid[r][c] != '.' {
                    column_chars.push(grid[r][c]);
                }
            }

            let num_chars = column_chars.len();
            for r in 0..rows {
                if r < rows - num_chars {
                    grid[r][c] = '.';
                } else {
                    grid[r][c] = column_chars[r - (rows - num_chars)];
                }
            }
        }

        let mut result = String::new();
        for r in 0..rows {
            for c in 0..cols {
                if grid[r][c] != '.' {
                    result.push(grid[r][c]);
                }
            }
        }

        result
    }
}