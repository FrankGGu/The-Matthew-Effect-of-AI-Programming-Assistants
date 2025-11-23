use std::collections::BinaryHeap;

impl Solution {
    pub fn min_cost_to_cut_cake(h: i32, w: i32, horizontal_cuts: Vec<i32>, vertical_cuts: Vec<i32>) -> i32 {
        let mut h_cuts = horizontal_cuts;
        let mut v_cuts = vertical_cuts;
        h_cuts.sort();
        v_cuts.sort();

        let max_h = Self::get_max_piece(&h_cuts, h);
        let max_v = Self::get_max_piece(&v_cuts, w);

        (max_h as i64 * max_v as i64 % 1_000_000_007) as i32
    }

    fn get_max_piece(cuts: &[i32], size: i32) -> i32 {
        let mut max = 0;
        let mut prev = 0;
        for &cut in cuts {
            max = max.max(cut - prev);
            prev = cut;
        }
        max.max(size - prev)
    }
}