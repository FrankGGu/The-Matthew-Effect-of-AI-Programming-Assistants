impl Solution {
    pub fn maximize_square_hole_area(n: i32, m: i32, h_bars: Vec<i32>, v_bars: Vec<i32>) -> i32 {
        fn max_consecutive(bars: Vec<i32>) -> i32 {
            let mut bars = bars;
            bars.sort();
            let mut max_len = 1;
            let mut current_len = 1;
            for i in 1..bars.len() {
                if bars[i] == bars[i - 1] + 1 {
                    current_len += 1;
                    max_len = max_len.max(current_len);
                } else {
                    current_len = 1;
                }
            }
            max_len + 1
        }

        let h_max = max_consecutive(h_bars);
        let v_max = max_consecutive(v_bars);
        let side = h_max.min(v_max);
        side * side
    }
}