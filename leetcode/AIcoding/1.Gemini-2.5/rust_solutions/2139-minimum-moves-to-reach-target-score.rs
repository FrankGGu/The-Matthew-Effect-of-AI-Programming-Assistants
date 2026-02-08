impl Solution {
    pub fn min_moves(target: i32, max_doubles: i32) -> i32 {
        let mut current_target = target;
        let mut current_max_doubles = max_doubles;
        let mut moves = 0;

        while current_target > 1 {
            if current_max_doubles == 0 {
                moves += current_target - 1;
                break;
            }

            if current_target % 2 == 0 {
                current_target /= 2;
                current_max_doubles -= 1;
                moves += 1;
            } else {
                current_target -= 1;
                moves += 1;
            }
        }

        moves
    }
}