var minimizedMaximum = function(n, quantities) {
    let low = 1;
    let high = 0;
    for (let q of quantities) {
        high = Math.max(high, q);
    }

    let ans = high;

    while (low <= high) {
        let mid = low + Math.floor((high - low) / 2);

        let storesNeeded = 0;
        for (let q of quantities) {
            storesNeeded += Math.ceil(q / mid);
        }

        if (storesNeeded <= n) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
};