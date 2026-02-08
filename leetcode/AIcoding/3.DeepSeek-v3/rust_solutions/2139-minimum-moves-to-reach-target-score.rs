impl Solution {
    pub fn min_moves(target: i32, max_doubles: i32) -> i32 {
        let mut target = target;
        let mut max_doubles = max_doubles;
        let mut moves = 0;

        while target > 1 && max_doubles > 0 {
            if target % 2 == 1 {
                target -= 1;
                moves += 1;
            }
            target /= 2;
            moves += 1;
            max_doubles -= 1;
        }

        moves + target - 1
    }
}