impl Solution {
    pub fn max_square_area(rect1: Vec<i32>, rect2: Vec<i32>) -> i32 {
        let (x1, y1, x2, y2) = (rect1[0], rect1[1], rect1[2], rect1[3]);
        let (x3, y3, x4, y4) = (rect2[0], rect2[1], rect2[2], rect2[3]);

        let x_overlap = ((x1.max(x3) - x1.min(x4)).max(0)) as i32;
        let y_overlap = ((y1.max(y3) - y1.min(y4)).max(0)) as i32;

        (x_overlap.min(y_overlap)).pow(2)
    }
}