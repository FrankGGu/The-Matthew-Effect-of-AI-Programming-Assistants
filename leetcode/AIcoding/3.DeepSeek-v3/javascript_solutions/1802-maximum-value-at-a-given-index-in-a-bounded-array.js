var maxValue = function(n, index, maxSum) {
    let left = 1, right = maxSum;
    while (left < right) {
        const mid = Math.floor((left + right + 1) / 2);
        if (getSum(mid, index, n) <= maxSum) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }
    return left;
};

function getSum(val, index, n) {
    let sum = 0;
    // Left side
    if (val > index) {
        sum += (val + val - index) * (index + 1) / 2;
    } else {
        sum += (val + 1) * val / 2 + (index - val + 1);
    }
    // Right side
    if (val >= n - index) {
        sum += (val + val - (n - 1 - index)) * (n - index) / 2;
    } else {
        sum += (val + 1) * val / 2 + (n - index - val);
    }
    return sum - val;
}