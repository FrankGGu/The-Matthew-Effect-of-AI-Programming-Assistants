var findKthNumber = function(m, n, k) {
    const countLessOrEqual = (val) => {
        let count = 0;
        for (let i = 1; i <= m; i++) {
            count += Math.min(n, Math.floor(val / i));
        }
        return count;
    };

    let low = 1;
    let high = m * n;
    let ans = m * n;

    while (low <= high) {
        let mid = Math.floor(low + (high - low) / 2);
        if (countLessOrEqual(mid) >= k) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};