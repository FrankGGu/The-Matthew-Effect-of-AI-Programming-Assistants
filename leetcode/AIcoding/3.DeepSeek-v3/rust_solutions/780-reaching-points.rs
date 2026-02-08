impl Solution {
    pub fn reaching_points(sx: i32, sy: i32, tx: i32, ty: i32) -> bool {
        let (mut x, mut y) = (tx, ty);
        while x >= sx && y >= sy {
            if x == sx && y == sy {
                return true;
            }
            if x > y {
                if y > sy {
                    x %= y;
                } else {
                    return (x - sx) % y == 0;
                }
            } else {
                if x > sx {
                    y %= x;
                } else {
                    return (y - sy) % x == 0;
                }
            }
        }
        false
    }
}