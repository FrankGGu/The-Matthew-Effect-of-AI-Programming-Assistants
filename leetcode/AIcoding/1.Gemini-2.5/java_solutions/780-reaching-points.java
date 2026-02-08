class Solution {
    public boolean reachingPoints(int sx, int sy, int tx, int ty) {
        while (tx >= sx && ty >= sy) {
            if (tx == sx && ty == sy) {
                return true;
            }
            if (tx > ty) {
                // If tx - sx < ty, it means tx is "close" to sx.
                // We cannot reduce tx by multiples of ty to reach sx,
                // because even one subtraction of ty would make tx less than sx (tx - ty < sx).
                // In this case, the only way to reach sx from tx is if tx - ty == sx.
                // If that's the case, we would have already reached (sx, ty) in a previous step
                // or the current tx is exactly sx + ty.
                // If we applied `tx = sx + (tx - sx) % ty` here, and `tx - sx < ty`,
                // then `(tx - sx) % ty` evaluates to `tx - sx`.
                // So, `tx` would become `sx + (tx - sx)`, which is `tx`.
                // This would lead to an infinite loop if `tx > sx`.
                // Therefore, if `tx - sx < ty`, we cannot make progress with modulo,
                // and should break to let the final return statement handle it.
                if (tx - sx < ty) {
                    break;
                }
                // Reduce tx by multiples of ty until it's the smallest value >= sx
                // that is congruent to tx modulo ty.
                tx = sx + (tx - sx) % ty;
            } else if (ty > tx) {
                // Similar logic for ty
                if (ty - sy < tx) {
                    break;
                }
                ty = sy + (ty - sy) % tx;
            } else { // tx == ty
                // If tx == ty, and we haven't reached (sx, sy), it's impossible to proceed.
                // Operations (x,y) -> (x, x+y) or (x+y, y) always increase one coordinate.
                // To get tx == ty, sx must equal sy.
                // If tx == ty and tx != sx (or ty != sy), then (tx, ty) cannot be reached.
                break;
            }
        }
        // If the loop finishes without returning true, it means (sx, sy) is unreachable.
        // This includes cases where the loop broke due to `tx - sx < ty`, `ty - sy < tx`, or `tx == ty`.
        // In all these cases, if (tx, ty) is not (sx, sy), it's impossible.
        return false;
    }
}