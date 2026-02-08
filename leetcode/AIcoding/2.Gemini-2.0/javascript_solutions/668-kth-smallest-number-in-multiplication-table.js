var findKthNumber = function(m, n, k) {
    let low = 1;
    let high = m * n;

    while (low < high) {
        let mid = low + Math.floor((high - low) / 2);
        let count = 0;
        for (let i = 1; i <= m; i++) {
            count += Math.min(Math.floor(mid / i), n);
        }
        if (count < k) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }

    return low;
};