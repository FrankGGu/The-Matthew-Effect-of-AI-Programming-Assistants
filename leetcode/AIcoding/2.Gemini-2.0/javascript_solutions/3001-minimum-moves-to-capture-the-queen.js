var minMovesToCaptureTheQueen = function(a, b, c, d, e, f) {
    let ans = 2;

    // Rook
    if (a === e) {
        if (c === e && ((d > b && d < f) || (d < b && d > f))) {
            // Bishop blocks
        } else {
            ans = 1;
        }
    } else if (b === f) {
        if (d === f && ((c > a && c < e) || (c < a && c > e))) {
            // Bishop blocks
        } else {
            ans = 1;
        }
    }

    // Bishop
    if (Math.abs(c - e) === Math.abs(d - f)) {
        let blocks = false;
        if (Math.abs(a - e) === Math.abs(b - f)) {
            if (a < e && b < f) {
                if (a < c && c < e && b < d && d < f && (c - a === d - b)) blocks = true;
            } else if (a < e && b > f) {
                if (a < c && c < e && b > d && d > f && (c - a === b - d)) blocks = true;
            } else if (a > e && b < f) {
                if (a > c && c > e && b < d && d < f && (a - c === d - b)) blocks = true;
            } else if (a > e && b > f) {
                if (a > c && c > e && b > d && d > f && (a - c === b - d)) blocks = true;
            }

        }
        if (!blocks) {
            ans = Math.min(ans, 1);
        }
    }

    return ans;
};