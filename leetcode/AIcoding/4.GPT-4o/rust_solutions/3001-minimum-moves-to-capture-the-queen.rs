impl Solution {
    pub fn min_distance_to_queen(queen: Vec<i32>, pawns: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result = Vec::new();
        let q_row = queen[0];
        let q_col = queen[1];

        for pawn in pawns {
            let p_row = pawn[0];
            let p_col = pawn[1];
            let distance = if q_row == p_row || q_col == p_col || (q_row - p_row).abs() == (q_col - p_col).abs() {
                (q_row - p_row).abs() + (q_col - p_col).abs()
            } else {
                -1
            };
            result.push(if distance == -1 { -1 } else { distance / 2 });
        }
        result
    }
}