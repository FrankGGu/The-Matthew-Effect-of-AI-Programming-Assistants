impl Solution {
    pub fn num_moves_stones(a: i32, b: i32, c: i32) -> Vec<i32> {
        let mut stones = [a, b, c];
        stones.sort();
        let min_moves = if stones[1] - stones[0] == 1 || stones[2] - stones[1] == 1 {
            0
        } else if stones[1] - stones[0] <= 2 || stones[2] - stones[1] <= 2 {
            1
        } else {
            2
        };
        let max_moves = stones[2] - stones[0] - 2;
        vec![min_moves, max_moves]
    }
}