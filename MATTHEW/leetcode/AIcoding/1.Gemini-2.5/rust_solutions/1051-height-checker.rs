impl Solution {
    pub fn height_checker(heights: Vec<i32>) -> i32 {
        let mut expected = heights.clone();
        expected.sort_unstable();

        let mut count = 0;
        for i in 0..heights.len() {
            if heights[i] != expected[i] {
                count += 1;
            }
        }
        count
    }
}