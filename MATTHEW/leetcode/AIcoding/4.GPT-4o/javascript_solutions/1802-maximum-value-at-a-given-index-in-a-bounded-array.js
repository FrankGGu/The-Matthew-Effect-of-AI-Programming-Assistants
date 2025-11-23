function maxValue(n, index, maxSum) {
    let left = Math.max(0, index);
    let right = Math.max(0, n - index - 1);

    const canDistribute = (val) => {
        let total = val;
        if (left > 0) {
            total += Math.max(0, val - left) * (left - (val > left ? 1 : 0)) / 2;
        }
        if (right > 0) {
            total += Math.max(0, val - right) * (right - (val > right ? 1 : 0)) / 2;
        }
        return total;
    };

    let low = 1, high = maxSum;
    while (low < high) {
        const mid = Math.floor((low + high + 1) / 2);
        if (canDistribute(mid) + mid <= maxSum) {
            low = mid;
        } else {
            high = mid - 1;
        }
    }

    return low;
}