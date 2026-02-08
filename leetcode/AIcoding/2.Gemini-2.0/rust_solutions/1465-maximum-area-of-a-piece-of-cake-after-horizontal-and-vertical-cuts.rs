impl Solution {
    pub fn max_area(h: i32, w: i32, horizontal_cuts: Vec<i32>, vertical_cuts: Vec<i32>) -> i32 {
        let mut horizontal_cuts = horizontal_cuts;
        let mut vertical_cuts = vertical_cuts;
        horizontal_cuts.sort();
        vertical_cuts.sort();

        let mut max_h = horizontal_cuts[0];
        for i in 1..horizontal_cuts.len() {
            max_h = std::cmp::max(max_h, horizontal_cuts[i] - horizontal_cuts[i - 1]);
        }
        max_h = std::cmp::max(max_h, h - horizontal_cuts[horizontal_cuts.len() - 1]);

        let mut max_w = vertical_cuts[0];
        for i in 1..vertical_cuts.len() {
            max_w = std::cmp::max(max_w, vertical_cuts[i] - vertical_cuts[i - 1]);
        }
        max_w = std::cmp::max(max_w, w - vertical_cuts[vertical_cuts.len() - 1]);

        ((max_h as i64) * (max_w as i64) % 1000000007) as i32
    }
}