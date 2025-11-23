impl Solution {
    pub fn num_moves_stonesII(stones: Vec<i32>) -> Vec<i32> {
        let mut stones = stones;
        stones.sort();
        let n = stones.len();
        let mut min_moves = n;
        let mut max_moves = (stones[n - 1] - stones[0] + 1 - n) as i32;

        for i in 0..n {
            while stones[i] - stones[0] + 1 > n as i32 {
                stones[0] += 1;
            }
            min_moves = min_moves.min(n as i32 - (i + 1) as i32 - (stones[i] - stones[0] + 1 - (i + 1) as i32) as i32);
        }

        if stones[0] == 1 && stones[n - 1] == n as i32 {
            min_moves = min_moves.min(1);
        } else if stones[0] == 1 || stones[n - 1] == n as i32 {
            min_moves = min_moves.min(2);
        }

        vec![min_moves, max_moves]
    }
}