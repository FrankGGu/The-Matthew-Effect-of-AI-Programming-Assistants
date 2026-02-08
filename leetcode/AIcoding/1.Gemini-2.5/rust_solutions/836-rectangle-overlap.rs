impl Solution {
    pub fn is_rectangle_overlap(rect1: Vec<i32>, rect2: Vec<i32>) -> bool {
        let x_overlap = rect1[0].max(rect2[0]) < rect1[2].min(rect2[2]);
        let y_overlap = rect1[1].max(rect2[1]) < rect1[3].min(rect2[3]);

        x_overlap && y_overlap
    }
}