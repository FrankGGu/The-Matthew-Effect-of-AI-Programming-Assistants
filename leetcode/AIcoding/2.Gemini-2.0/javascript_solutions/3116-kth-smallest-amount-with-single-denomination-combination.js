var kthSmallestAmount = function(costs, target, k) {
    let low = 0;
    let high = Math.max(...costs) * target;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        let count = 0;
        for (let cost of costs) {
            count += Math.floor(mid / cost);
        }

        if (count >= k) {
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return low;
};