struct Solution;

impl Solution {
    pub fn min_moves_to_capture_the_queen(p1: Vec<i32>, p2: Vec<i32>, q: Vec<i32>) -> i32 {
        let (x1, y1) = (p1[0], p1[1]);
        let (x2, y2) = (p2[0], p2[1]);
        let (qx, qy) = (q[0], q[1]);

        let dx1 = if x1 < qx { 1 } else if x1 > qx { -1 } else { 0 };
        let dy1 = if y1 < qy { 1 } else if y1 > qy { -1 } else { 0 };

        let dx2 = if x2 < qx { 1 } else if x2 > qx { -1 } else { 0 };
        let dy2 = if y2 < qy { 1 } else if y2 > qy { -1 } else { 0 };

        let mut steps1 = 0;
        let mut steps2 = 0;

        let mut x = x1;
        let mut y = y1;
        while x != qx || y != qy {
            x += dx1;
            y += dy1;
            steps1 += 1;
        }

        x = x2;
        y = y2;
        while x != qx || y != qy {
            x += dx2;
            y += dy2;
            steps2 += 1;
        }

        steps1.min(steps2)
    }
}