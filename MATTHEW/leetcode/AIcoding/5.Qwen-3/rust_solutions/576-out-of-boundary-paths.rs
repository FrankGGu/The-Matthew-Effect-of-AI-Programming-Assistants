struct Solution;

impl Solution {
    pub fn find_paths(m: i32, n: i32, max_moves: i32, start_row: i32, start_col: i32) -> i32 {
        use std::collections::HashMap;

        type State = (i32, i32, i32);
        let mut memo = HashMap::new();

        fn dfs(
            m: i32,
            n: i32,
            moves_left: i32,
            row: i32,
            col: i32,
            memo: &mut HashMap<(i32, i32, i32), i32>,
        ) -> i32 {
            if row < 0 || row >= m || col < 0 || col >= n {
                return 1;
            }
            if moves_left == 0 {
                return 0;
            }
            let key = (row, col, moves_left);
            if let Some(&result) = memo.get(&key) {
                return result;
            }

            let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
            let mut count = 0;
            for &(dr, dc) in &directions {
                count += dfs(
                    m,
                    n,
                    moves_left - 1,
                    row + dr,
                    col + dc,
                    memo,
                );
            }

            memo.insert(key, count);
            count
        }

        dfs(m, n, max_moves, start_row, start_col, &mut memo)
    }
}