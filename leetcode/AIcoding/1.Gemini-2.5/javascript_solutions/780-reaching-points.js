var reachingPoints = function(sx, sy, tx, ty) {
    while (tx >= sx && ty >= sy) {
        if (tx === sx && ty === sy) {
            return true;
        }

        if (tx === ty) {
            // If tx and ty are equal, and not equal to sx and sy respectively,
            // it's impossible to reach (sx, sy) because we can't go backwards
            // from (k, k) to (x, y) where x,y > 0.
            break;
        }

        if (tx > ty) {
            // If ty is already sy, we can only subtract multiples of ty from tx.
            // For (sx, sy) to reach (tx, sy), (tx - sx) must be a multiple of sy.
            if (ty === sy) {
                return (tx - sx) % ty === 0;
            }
            tx %= ty;
        } else { // ty > tx
            // If tx is already sx, we can only subtract multiples of tx from ty.
            // For (sx, sy) to reach (sx, ty), (ty - sy) must be a multiple of sx.
            if (tx === sx) {
                return (ty - sy) % tx === 0;
            }
            ty %= tx;
        }
    }
    return false;
};