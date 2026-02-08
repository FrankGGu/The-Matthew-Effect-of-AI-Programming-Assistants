impl Solution {
    pub fn relocate_marbles(marbles: Vec<i32>, moves: Vec<Vec<i32>>) -> Vec<i32> {
        let mut positions: std::collections::HashSet<i32> = marbles.into_iter().collect();
        for move_pair in moves {
            let (from, to) = (move_pair[0], move_pair[1]);
            if positions.remove(&from) {
                positions.insert(to);
            }
        }
        let mut result: Vec<i32> = positions.into_iter().collect();
        result.sort();
        result
    }
}