impl Solution {
    pub fn minimum_cost(m: i32, n: i32, mut horizontal_cut: Vec<i32>, mut vertical_cut: Vec<i32>) -> i64 {
        // Sort cuts in descending order. This greedy strategy ensures that
        // more expensive cuts are made when the number of existing pieces (multiplier) is smaller.
        horizontal_cut.sort_unstable_by(|a, b| b.cmp(a));
        vertical_cut.sort_unstable_by(|a, b| b.cmp(a));

        let mut total_cost: i64 = 0;
        let mut h_pieces: i64 = 1; // Number of horizontal pieces the cake is currently divided into
        let mut v_pieces: i64 = 1; // Number of vertical pieces the cake is currently divided into

        let mut h_idx = 0;
        let mut v_idx = 0;

        // Continue as long as there are horizontal or vertical cuts remaining
        while h_idx < horizontal_cut.len() || v_idx < vertical_cut.len() {
            // Decide which cut to make next:
            // 1. If all vertical cuts are exhausted, make a horizontal cut.
            // 2. If all horizontal cuts are exhausted, make a vertical cut.
            // 3. Otherwise, compare the costs of the next available horizontal and vertical cuts.
            //    Make the cut with the higher cost.
            if h_idx < horizontal_cut.len() && (v_idx == vertical_cut.len() || horizontal_cut[h_idx] >= vertical_cut[v_idx]) {
                // Make a horizontal cut
                total_cost += horizontal_cut[h_idx] as i64 * v_pieces;
                h_pieces += 1;
                h_idx += 1;
            } else {
                // Make a vertical cut
                total_cost += vertical_cut[v_idx] as i64 * h_pieces;
                v_pieces += 1;
                v_idx += 1;
            }
        }

        total_cost
    }
}