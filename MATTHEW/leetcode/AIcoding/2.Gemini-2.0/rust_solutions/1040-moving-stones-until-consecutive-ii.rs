impl Solution {
    pub fn num_moves_stones_ii(stones: Vec<i32>) -> Vec<i32> {
        let mut stones = stones;
        stones.sort();
        let n = stones.len();
        let max_moves = std::cmp::max(stones[n - 1] - stones[1] - n as i32 + 2, stones[n - 2] - stones[0] - n as i32 + 2);
        let mut min_moves = i32::MAX;
        let mut i = 0;
        for j in 0..n {
            while stones[j] - stones[i] + 1 > n as i32 {
                i += 1;
            }
            let count = j - i + 1;
            if count == n && stones[j] - stones[i] + 1 != n as i32 {
                min_moves = std::cmp::min(min_moves, 2);
            } else {
                min_moves = std::cmp::min(min_moves, n as i32 - count);
            }
        }
        vec![min_moves, max_moves]
    }
}