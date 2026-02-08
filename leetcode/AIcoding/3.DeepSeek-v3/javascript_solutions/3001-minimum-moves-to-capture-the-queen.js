var minMovesToCaptureTheQueen = function(a, b, c, d, e, f) {
    // Check if the rook can capture the queen directly
    if (a === e && (c !== e || (d < Math.min(b, f) || d > Math.max(b, f)))) {
        return 1;
    }
    if (b === f && (d !== f || (c < Math.min(a, e) || c > Math.max(a, e)))) {
        return 1;
    }
    // Check if the bishop can capture the queen directly
    if (Math.abs(c - e) === Math.abs(d - f)) {
        if (Math.abs(a - c) !== Math.abs(b - d) || 
            (e < Math.min(a, c) || e > Math.max(a, c)) || 
            (f < Math.min(b, d) || f > Math.max(b, d))) {
            return 1;
        }
    }
    // Otherwise, the minimum moves is 2
    return 2;
};