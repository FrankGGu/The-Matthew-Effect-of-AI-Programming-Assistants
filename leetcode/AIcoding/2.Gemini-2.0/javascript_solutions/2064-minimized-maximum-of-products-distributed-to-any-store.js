var minimizedMaximum = function(n, quantities) {
    let left = 1;
    let right = Math.max(...quantities);

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        let storesNeeded = 0;
        for (let quantity of quantities) {
            storesNeeded += Math.ceil(quantity / mid);
        }

        if (storesNeeded <= n) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
};