impl Solution {
    pub fn count_good_rectangles(rectangles: Vec<Vec<i32>>) -> i32 {
        let mut max_side = 0;
        for rect in &rectangles {
            let current_side = rect[0].min(rect[1]);
            max_side = max_side.max(current_side);
        }

        let mut count = 0;
        for rect in &rectangles {
            let current_side = rect[0].min(rect[1]);
            if current_side == max_side {
                count += 1;
            }
        }
        count
    }
}