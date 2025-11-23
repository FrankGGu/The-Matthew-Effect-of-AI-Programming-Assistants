class Solution {
public:
    bool reachingPoints(int sx, int sy, int tx, int ty) {
        while (tx >= sx && ty >= sy) {
            if (tx == sx && ty == sy) {
                return true;
            }
            if (tx == ty) {
                // If tx == ty and we haven't reached (sx, sy), it's impossible to reach.
                // Any backward step would require one coordinate to be 0 or negative,
                // which is not allowed as sx, sy, tx, ty are positive.
                break;
            }
            if (tx > ty) {
                // If ty is already sy, we can only reduce tx by subtracting ty.
                // We need tx to become sx. This means (tx - sx) must be a non-negative multiple of ty.
                if (ty == sy) {
                    return (tx >= sx && (tx - sx) % ty == 0);
                }
                // Otherwise, reduce tx by ty using modulo. This efficiently subtracts ty multiple times.
                tx %= ty;
            } else { // ty > tx
                // If tx is already sx, we can only reduce ty by subtracting tx.
                // We need ty to become sy. This means (ty - sy) must be a non-negative multiple of tx.
                if (tx == sx) {
                    return (ty >= sy && (ty - sy) % tx == 0);
                }
                // Otherwise, reduce ty by tx using modulo.
                ty %= tx;
            }
        }
        return false; // Either tx < sx or ty < sy, meaning we overshot the starting point.
    }
};