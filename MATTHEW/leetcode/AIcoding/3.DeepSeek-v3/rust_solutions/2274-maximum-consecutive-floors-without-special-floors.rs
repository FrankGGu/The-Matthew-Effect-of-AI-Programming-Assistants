impl Solution {
    pub fn max_consecutive(bottom: i32, top: i32, special: Vec<i32>) -> i32 {
        let mut special = special;
        special.sort_unstable();
        let mut max = 0;
        let mut prev = bottom;

        for &floor in special.iter() {
            max = max.max(floor - prev);
            prev = floor + 1;
        }

        max.max(top - prev + 1)
    }
}