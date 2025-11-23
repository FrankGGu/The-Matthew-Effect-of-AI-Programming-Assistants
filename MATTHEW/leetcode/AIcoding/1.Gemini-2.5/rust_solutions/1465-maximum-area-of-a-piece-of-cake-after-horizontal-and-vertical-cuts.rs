impl Solution {
    pub fn max_area(h: i32, w: i32, horizontal_cuts: Vec<i32>, vertical_cuts: Vec<i32>) -> i32 {
        let modulo: i64 = 1_000_000_007;

        let mut h_cuts = horizontal_cuts;
        h_cuts.push(0);
        h_cuts.push(h);
        h_cuts.sort_unstable();

        let mut max_h_diff = 0;
        for i in 1..h_cuts.len() {
            max_h_diff = max_h_diff.max(h_cuts[i] - h_cuts[i - 1]);
        }

        let mut v_cuts = vertical_cuts;
        v_cuts.push(0);
        v_cuts.push(w);
        v_cuts.sort_unstable();

        let mut max_v_diff = 0;
        for i in 1..v_cuts.len() {
            max_v_diff = max_v_diff.max(v_cuts[i] - v_cuts[i - 1]);
        }

        ((max_h_diff as i64 * max_v_diff as i64) % modulo) as i32
    }
}