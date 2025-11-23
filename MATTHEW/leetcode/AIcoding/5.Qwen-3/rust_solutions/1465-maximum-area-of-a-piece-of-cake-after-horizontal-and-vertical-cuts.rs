struct Solution;

impl Solution {
    pub fn max_area(h: i32, w: i32, horizontal_cuts: Vec<i32>, vertical_cuts: Vec<i32>) -> i32 {
        let mut horizontal = horizontal_cuts;
        let mut vertical = vertical_cuts;

        horizontal.push(0);
        horizontal.push(h);
        vertical.push(0);
        vertical.push(w);

        horizontal.sort();
        vertical.sort();

        let mut max_h = 0;
        for i in 1..horizontal.len() {
            max_h = std::cmp::max(max_h, horizontal[i] - horizontal[i - 1]);
        }

        let mut max_v = 0;
        for i in 1..vertical.len() {
            max_v = std::cmp::max(max_v, vertical[i] - vertical[i - 1]);
        }

        max_h * max_v
    }
}