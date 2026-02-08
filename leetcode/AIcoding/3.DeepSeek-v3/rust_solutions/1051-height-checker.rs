impl Solution {
    pub fn height_checker(heights: Vec<i32>) -> i32 {
        let mut sorted_heights = heights.clone();
        sorted_heights.sort_unstable();
        heights.iter().zip(sorted_heights.iter()).filter(|(a, b)| a != b).count() as i32
    }
}