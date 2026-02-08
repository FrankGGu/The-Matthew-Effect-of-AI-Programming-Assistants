var mySqrt = function(x) {
    if (x === 0) return 0;
    let left = 1, right = x;
    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (mid * mid === x) {
            return mid;
        } else if (mid * mid < x) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return right;
};