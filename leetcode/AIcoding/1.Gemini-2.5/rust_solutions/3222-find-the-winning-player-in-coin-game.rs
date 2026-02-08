impl Solution {
    pub fn find_winning_player(x: i32, y: i32) -> String {
        let moves_type1 = x.min(y);
        let remaining_y = y - moves_type1;
        let moves_type2 = remaining_y / 3;

        let total_moves = moves_type1 + moves_type2;

        if total_moves % 2 == 1 {
            "Alice".to_string()
        } else {
            "Bob".to_string()
        }
    }
}