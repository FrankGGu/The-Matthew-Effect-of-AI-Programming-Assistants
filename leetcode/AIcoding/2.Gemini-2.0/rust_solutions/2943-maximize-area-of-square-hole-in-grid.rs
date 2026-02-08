impl Solution {
    pub fn maximize_square_hole_area(n: i32, m: i32, h_bars: Vec<i32>, v_bars: Vec<i32>) -> i32 {
        fn get_max_consecutive(bars: &Vec<i32>, n: i32) -> i32 {
            let mut sorted_bars = bars.clone();
            sorted_bars.sort();
            let mut max_consecutive = 1;
            let mut current_consecutive = 1;
            for i in 1..sorted_bars.len() {
                if sorted_bars[i] == sorted_bars[i - 1] + 1 {
                    current_consecutive += 1;
                    max_consecutive = max_consecutive.max(current_consecutive);
                } else {
                    current_consecutive = 1;
                }
            }
            max_consecutive + 1
        }

        let horizontal_side = get_max_consecutive(&h_bars, n);
        let vertical_side = get_max_consecutive(&v_bars, m);

        horizontal_side.min(vertical_side).pow(2)
    }
}