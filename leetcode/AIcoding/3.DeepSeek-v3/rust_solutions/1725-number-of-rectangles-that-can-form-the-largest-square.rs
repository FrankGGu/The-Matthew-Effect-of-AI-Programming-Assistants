impl Solution {
    pub fn count_good_rectangles(rectangles: Vec<Vec<i32>>) -> i32 {
        let max_len = rectangles.iter().map(|r| r[0].min(r[1])).max().unwrap_or(0);
        rectangles.iter().filter(|r| r[0].min(r[1]) == max_len).count() as i32
    }
}