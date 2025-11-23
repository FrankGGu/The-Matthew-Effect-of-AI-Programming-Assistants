var getMaxProfit = function(inventory, orders) {
    let left = 0, right = Math.max(...inventory), result = 0, mod = 1e9 + 7;

    while (left < right) {
        let mid = Math.floor((left + right + 1) / 2);
        let totalOrders = 0;

        for (let num of inventory) {
            if (num > mid) {
                totalOrders += num - mid;
            }
        }

        if (totalOrders >= orders) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    for (let num of inventory) {
        if (num > left) {
            result = (result + ((num + left + 1) * (num - left) / 2) % mod) % mod;
        }
    }

    result = (result + left * orders) % mod;
    return result;
};