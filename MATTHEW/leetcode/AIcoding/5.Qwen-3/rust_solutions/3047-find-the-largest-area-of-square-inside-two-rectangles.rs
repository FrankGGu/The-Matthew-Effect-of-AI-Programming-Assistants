struct Solution;

impl Solution {
    pub fn largest_square_area(rect1: Vec<i32>, rect2: Vec<i32>) -> i32 {
        let x1 = rect1[0];
        let y1 = rect1[1];
        let x2 = rect1[2];
        let y2 = rect1[3];

        let x3 = rect2[0];
        let y3 = rect2[1];
        let x4 = rect2[2];
        let y4 = rect2[3];

        let overlap_x1 = x1.max(x3);
        let overlap_y1 = y1.max(y3);
        let overlap_x2 = x2.min(x4);
        let overlap_y2 = y2.min(y4);

        if overlap_x1 >= overlap_x2 || overlap_y1 >= overlap_y2 {
            return 0;
        }

        let width = overlap_x2 - overlap_x1;
        let height = overlap_y2 - overlap_y1;

        width.min(height)
    }
}