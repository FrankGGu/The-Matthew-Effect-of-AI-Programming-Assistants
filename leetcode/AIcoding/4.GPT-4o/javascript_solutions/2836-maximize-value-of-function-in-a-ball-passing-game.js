var maxValue = function(n, index, maxSum) {
    let left = Math.max(1, index);
    let right = Math.max(1, n - index);

    const getSum = (x, len) => {
        if (len <= x) return (len * (x + (x - len + 1))) / 2;
        return (x * (x + 1)) / 2 + (len - x);
    };

    const canAchieve = (mid) => {
        const leftSum = getSum(mid - 1, left);
        const rightSum = getSum(mid - 1, right);
        return leftSum + rightSum + mid <= maxSum;
    };

    let low = 1, high = maxSum;
    while (low < high) {
        const mid = Math.floor((low + high + 1) / 2);
        if (canAchieve(mid)) low = mid;
        else high = mid - 1;
    }
    return low;
};