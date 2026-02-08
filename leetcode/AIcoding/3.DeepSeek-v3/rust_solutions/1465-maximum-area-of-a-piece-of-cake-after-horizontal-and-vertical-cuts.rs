impl Solution {
    pub fn max_area(h: i32, w: i32, horizontal_cuts: Vec<i32>, vertical_cuts: Vec<i32>) -> i32 {
        let mut horizontal_cuts = horizontal_cuts;
        let mut vertical_cuts = vertical_cuts;
        horizontal_cuts.sort();
        vertical_cuts.sort();

        let max_h = std::cmp::max(
            horizontal_cuts[0],
            h - horizontal_cuts.last().unwrap_or(&0)
        );
        let max_w = std::cmp::max(
            vertical_cuts[0],
            w - vertical_cuts.last().unwrap_or(&0)
        );

        let max_h = horizontal_cuts.windows(2).fold(max_h, |acc, x| std::cmp::max(acc, x[1] - x[0]));
        let max_w = vertical_cuts.windows(2).fold(max_w, |acc, x| std::cmp::max(acc, x[1] - x[0]));

        ((max_h as i64 * max_w as i64) % 1_000_000_007) as i32
    }
}