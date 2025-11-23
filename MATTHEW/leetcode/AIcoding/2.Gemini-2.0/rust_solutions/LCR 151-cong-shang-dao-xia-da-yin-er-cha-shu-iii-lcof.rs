impl Solution {
    pub fn record_decoration(heights: Vec<i32>, decorations: Vec<i32>) -> i64 {
        let n = heights.len();
        let mut ans = 0;
        for i in 0..n {
            ans += (heights[i] as i64) * (decorations[i] as i64);
        }
        ans
    }
}