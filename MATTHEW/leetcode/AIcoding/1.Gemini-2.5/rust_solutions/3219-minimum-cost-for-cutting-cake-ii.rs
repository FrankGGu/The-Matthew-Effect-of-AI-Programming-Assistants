impl Solution {
    pub fn minimum_cost(m: i32, n: i32, mut horizontal_cut: Vec<i32>, mut vertical_cut: Vec<i32>) -> i64 {
        horizontal_cut.sort_unstable_by(|a, b| b.cmp(a));
        vertical_cut.sort_unstable_by(|a, b| b.cmp(a));

        let mut total_cost: i64 = 0;
        let mut h_pieces: i64 = 1; 
        let mut v_pieces: i64 = 1; 

        let mut h_idx: usize = 0;
        let mut v_idx: usize = 0;

        while h_idx < horizontal_cut.len() || v_idx < vertical_cut.len() {
            if h_idx < horizontal_cut.len() && (v_idx == vertical_cut.len() || horizontal_cut[h_idx] >= vertical_cut[v_idx]) {
                total_cost += horizontal_cut[h_idx] as i64 * v_pieces;
                h_pieces += 1;
                h_idx += 1;
            } else {
                total_cost += vertical_cut[v_idx] as i64 * h_pieces;
                v_pieces += 1;
                v_idx += 1;
            }
        }

        total_cost
    }
}