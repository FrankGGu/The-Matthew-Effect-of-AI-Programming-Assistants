impl Solution {
    pub fn compute_area(
        ax1: i32,
        ay1: i32,
        ax2: i32,
        ay2: i32,
        bx1: i32,
        by1: i32,
        bx2: i32,
        by2: i32,
    ) -> i32 {
        let area1 = (ax2 - ax1) * (ay2 - ay1);
        let area2 = (bx2 - bx1) * (by2 - by1);

        let overlap_x1 = ax1.max(bx1);
        let overlap_y1 = ay1.max(by1);
        let overlap_x2 = ax2.min(bx2);
        let overlap_y2 = ay2.min(by2);

        let overlap_width = (overlap_x2 - overlap_x1).max(0);
        let overlap_height = (overlap_y2 - overlap_y1).max(0);

        let overlap_area = overlap_width * overlap_height;

        area1 + area2 - overlap_area
    }
}