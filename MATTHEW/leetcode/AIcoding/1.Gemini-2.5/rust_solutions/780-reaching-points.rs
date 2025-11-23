impl Solution {
    pub fn reaching_points(sx: i32, sy: i32, mut tx: i32, mut ty: i32) -> bool {
        while tx >= sx && ty >= sy {
            if tx == sx && ty == sy {
                return true;
            }
            if tx == ty {
                return false;
            }

            if tx > ty {
                if tx == sx {
                    break;
                }
                tx %= ty;
            } else { // ty > tx
                if ty == sy {
                    break;
                }
                ty %= tx;
            }
        }

        if tx == sx && ty >= sy {
            return (ty - sy) % sx == 0;
        }
        if ty == sy && tx >= sx {
            return (tx - sx) % sy == 0;
        }

        false
    }
}