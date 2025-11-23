struct Solution {}

impl Solution {
    pub fn min_moves(target: i32, max_move: i32) -> i32 {
        let mut moves = 0;
        let mut current = 0;
        while current < target {
            current += max_move;
            moves += 1;
            if current > target {
                current -= max_move;
                break;
            }
        }
        if current == target {
            return moves;
        }
        let remaining = target - current;
        moves += (remaining + max_move - 1) / max_move;
        moves
    }
}