impl Solution {
    pub fn num_moves_stones(a: i32, b: i32, c: i32) -> Vec<i32> {
        let mut stones = vec![a, b, c];
        stones.sort_unstable(); 

        let x = stones[0];
        let y = stones[1];
        let z = stones[2];

        let min_moves: i32;
        if z - x == 2 {
            min_moves = 0;
        } else if y - x <= 2 || z - y <= 2 {
            min_moves = 1;
        } else {
            min_moves = 2;
        }

        let max_moves = (y - x - 1) + (z - y - 1);

        vec![min_moves, max_moves]
    }
}