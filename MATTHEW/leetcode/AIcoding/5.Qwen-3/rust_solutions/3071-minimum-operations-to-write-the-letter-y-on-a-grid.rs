impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn minimum_operations_to_write_y(grid: Vec<Vec<char>>) -> i32 {
        let n = grid.len();
        let mut y_positions = HashSet::new();
        let mut center = (n / 2, n / 2);

        for i in 0..n {
            y_positions.insert((i, 0));
            y_positions.insert((i, n - 1));
            if i < n / 2 {
                y_positions.insert((0, i));
                y_positions.insert((n - 1, i));
            }
        }

        y_positions.insert(center);

        let mut count = vec![0; 26];

        for i in 0..n {
            for j in 0..n {
                if y_positions.contains(&(i, j)) {
                    let idx = (grid[i][j] as u8 - b'a') as usize;
                    count[idx] += 1;
                }
            }
        }

        let total = n * n;
        let y_count = y_positions.len();
        let non_y_count = total - y_count;

        let max_y_char = count.iter().enumerate().max_by_key(|&(_, &c)| c).unwrap().0;
        let y_char = (b'a' + max_y_char) as char;

        let mut operations = 0;
        for i in 0..n {
            for j in 0..n {
                if y_positions.contains(&(i, j)) {
                    if grid[i][j] != y_char {
                        operations += 1;
                    }
                }
            }
        }

        operations
    }
}
}