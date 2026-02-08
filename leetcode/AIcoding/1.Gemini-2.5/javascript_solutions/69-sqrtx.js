var mySqrt = function(x) {
    if (x < 0) {
        // As per problem constraints, x is non-negative.
        // This case should not be reached for valid inputs.
        return NaN; 
    }
    if (x === 0) {
        return 0;
    }

    let left = 1;
    let right = x;
    let ans = 0;

    while (left <= right) {
        let mid = Math.floor(left + (right - left) / 2);

        // Use `mid > x / mid` to prevent potential overflow if `mid * mid` is too large
        // for languages with fixed-size integers. However, in JavaScript, numbers are
        // double-precision floats, and `mid * mid` will correctly handle values up to
        // 2^53-1 (safe integer limit) and higher with some precision loss.
        // For x up to 2^31-1, mid*mid will not exceed 2^32, which is well within
        // JavaScript's safe integer range. So `mid * mid` is fine.
        if (mid * mid <= x) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
};