impl Solution {
    pub fn min_moves(target: i32, max_doubles: i32) -> i32 {
        let mut moves = 0;
        let mut target = target;
        let mut max_doubles = max_doubles;

        while target > 1 {
            if max_doubles > 0 && target % 2 == 0 {
                target /= 2;
                max_doubles -= 1;
            } else {
                target -= 1;
            }
            moves += 1;
        }

        moves
    }
}