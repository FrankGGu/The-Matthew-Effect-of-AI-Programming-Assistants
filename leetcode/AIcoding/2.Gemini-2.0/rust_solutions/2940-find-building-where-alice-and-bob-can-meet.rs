impl Solution {
    pub fn find_buildings(heights: Vec<i32>) -> Vec<i32> {
        let n = heights.len();
        let mut result: Vec<i32> = Vec::new();
        let mut max_height = -1;

        for i in 0..n {
            if heights[i] > max_height {
                result.push(i as i32);
                max_height = heights[i];
            }
        }

        result
    }
}