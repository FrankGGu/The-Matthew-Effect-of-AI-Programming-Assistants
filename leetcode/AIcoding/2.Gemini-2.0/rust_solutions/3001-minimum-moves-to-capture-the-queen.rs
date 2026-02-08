impl Solution {
    pub fn min_moves_to_capture_queen(
        rx: i32,
        ry: i32,
        bx: i32,
        by: i32,
        kx: i32,
        ky: i32,
    ) -> i32 {
        let mut ans = 2;

        // Check rook
        let mut blocked = false;
        if rx == kx {
            if (ry < ky && ky < ry.max(ky) || ry > ky && ky > ry.min(ky)) {
                blocked = true;
            }
        }
        if ry == ky {
            if (rx < kx && kx < rx.max(kx) || rx > kx && kx > rx.min(kx)) {
                blocked = true;
            }
        }
        if rx == bx {
            if (ry < by && by < ry.max(by) || ry > by && by > ry.min(by)) {
                return 1;
            }
        }
        if ry == by {
            if (rx < bx && bx < rx.max(bx) || rx > bx && bx > rx.min(bx)) {
                return 1;
            }
        }

        if rx == kx || ry == ky {
            if !blocked {
                ans = ans.min(1);
            }
        }

        // Check bishop
        blocked = false;
        if (bx - kx).abs() == (by - ky).abs() {
            if (bx - rx).signum() == (kx - rx).signum() && (by - ry).signum() == (ky - ry).signum() {
                if (bx - rx).abs() == (by - ry).abs() {
                    if (rx - bx).signum() == (kx - bx).signum() && (ry - by).signum() == (ky - by).signum() {
                        blocked = true;
                    }
                }
            }
        }

        if (bx - rx).abs() == (by - ry).abs() {
            if !blocked {
                ans = ans.min(1);
            }
        }

        ans
    }
}