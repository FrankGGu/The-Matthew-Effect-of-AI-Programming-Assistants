use std::collections::HashMap;

impl Solution {
    pub fn min_cost(height: i32, width: i32, horizontal_cuts: Vec<i32>, vertical_cuts: Vec<i32>) -> i32 {
        let mut h = horizontal_cuts;
        let mut v = vertical_cuts;
        h.sort();
        v.sort();

        let mut h_cuts = vec![0];
        h_cuts.extend(h.clone());
        h_cuts.push(height);

        let mut v_cuts = vec![0];
        v_cuts.extend(v.clone());
        v_cuts.push(width);

        let mut h_diffs = Vec::new();
        for i in 1..h_cuts.len() {
            h_diffs.push(h_cuts[i] - h_cuts[i - 1]);
        }

        let mut v_diffs = Vec::new();
        for i in 1..v_cuts.len() {
            v_diffs.push(v_cuts[i] - v_cuts[i - 1]);
        }

        let h_len = h_diffs.len();
        let v_len = v_diffs.len();

        let mut dp = HashMap::new();

        fn solve(h_start: usize, h_end: usize, v_start: usize, v_end: usize, h_diffs: &Vec<i32>, v_diffs: &Vec<i32>, dp: &mut HashMap<(usize, usize, usize, usize), i32>) -> i32 {
            if h_start >= h_end || v_start >= v_end {
                return 0;
            }

            if let Some(&cost) = dp.get(&(h_start, h_end, v_start, v_end)) {
                return cost;
            }

            let mut cost = std::i32::MAX;

            for i in h_start..h_end {
                let h_cost = h_diffs[i] * (v_cuts[v_end] - v_cuts[v_start]);
                cost = cost.min(solve(h_start, i, v_start, v_end, h_diffs, v_diffs, dp) + solve(i + 1, h_end, v_start, v_end, h_diffs, v_diffs, dp) + h_cost);
            }

            for j in v_start..v_end {
                let v_cost = v_diffs[j] * (h_cuts[h_end] - h_cuts[h_start]);
                cost = cost.min(solve(h_start, h_end, v_start, j, h_diffs, v_diffs, dp) + solve(h_start, h_end, j + 1, v_end, h_diffs, v_diffs, dp) + v_cost);
            }

            dp.insert((h_start, h_end, v_start, v_end), cost);
            cost
        }

        let h_cuts: Vec<i32> = h_cuts;
        let v_cuts: Vec<i32> = v_cuts;
        solve(0, h_len, 0, v_len, &h_diffs, &v_diffs, &mut dp)
    }
}