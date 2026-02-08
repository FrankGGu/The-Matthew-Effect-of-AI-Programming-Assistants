var minEatingSpeed = function(stock, cnt) {
    let left = 1;
    let right = Math.max(...stock);
    let ans = right;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let pieces = 0;
        for (let i = 0; i < stock.length; i++) {
            pieces += Math.ceil(stock[i] / mid);
        }

        if (pieces <= cnt) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
};