impl Solution {
    pub fn solve(tomato_slices: i32, cheese_slices: i32) -> Vec<i32> {
        if tomato_slices < 0 || cheese_slices < 0 {
            return vec![];
        }

        let jumbo = (tomato_slices - 2 * cheese_slices) as f64 / 2.0;
        let small = cheese_slices as f64 - jumbo;

        if jumbo.fract() != 0.0 || small.fract() != 0.0 || jumbo < 0.0 || small < 0.0 {
            return vec![];
        }

        vec![jumbo as i32, small as i32]
    }
}