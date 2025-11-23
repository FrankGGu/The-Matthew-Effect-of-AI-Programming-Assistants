var isRectangleCover = function(sx, sy, fx, fy) {
    function gcd(a, b) {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    }

    const dx = Math.abs(sx - fx);
    const dy = Math.abs(sy - fy);

    return gcd(dx, dy) === 1;
};