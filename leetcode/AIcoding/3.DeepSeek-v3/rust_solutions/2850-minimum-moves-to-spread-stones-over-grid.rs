use std::collections::VecDeque;

impl Solution {
    pub fn minimum_moves(grid: Vec<Vec<i32>>) -> i32 {
        let mut stones = Vec::new();
        let mut holes = Vec::new();
        for i in 0..3 {
            for j in 0..3 {
                let val = grid[i][j];
                if val > 1 {
                    stones.push((i as i32, j as i32, val - 1));
                } else if val == 0 {
                    holes.push((i as i32, j as i32));
                }
            }
        }
        if holes.is_empty() {
            return 0;
        }
        let mut min_moves = i32::MAX;
        Self::backtrack(&stones, &holes, 0, 0, &mut min_moves);
        min_moves
    }

    fn backtrack(stones: &[(i32, i32, i32)], holes: &[(i32, i32)], index: usize, moves: i32, min_moves: &mut i32) {
        if index == holes.len() {
            *min_moves = (*min_moves).min(moves);
            return;
        }
        let (hx, hy) = holes[index];
        for i in 0..stones.len() {
            let (sx, sy, count) = stones[i];
            if count > 0 {
                let dist = (sx - hx).abs() + (sy - hy).abs();
                let mut new_stones = stones.to_vec();
                new_stones[i] = (sx, sy, count - 1);
                Self::backtrack(&new_stones, holes, index + 1, moves + dist, min_moves);
            }
        }
    }
}