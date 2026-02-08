impl Solution {
    pub fn reaching_points(sx: i32, sy: i32, tx: i32, ty: i32) -> bool {
        let mut tx = tx as i64;
        let mut ty = ty as i64;
        let sx = sx as i64;
        let sy = sy as i64;

        while tx >= sx && ty >= sy {
            if tx == sx && ty == sy {
                return true;
            }

            if tx > ty {
                if ty == sy {
                    if (tx - sx) % ty == 0 {
                        return true;
                    } else {
                        return false;
                    }
                }
                tx %= ty;
            } else {
                if tx == sx {
                    if (ty - sy) % tx == 0 {
                        return true;
                    } else {
                        return false;
                    }
                }
                ty %= tx;
            }
        }

        false
    }
}