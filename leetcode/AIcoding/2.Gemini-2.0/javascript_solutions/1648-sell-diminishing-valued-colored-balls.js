var maxProfit = function(inventory, orders) {
    let left = 1;
    let right = Math.max(...inventory);
    let mod = 10**9 + 7;

    while (left < right) {
        let mid = Math.floor((left + right + 1) / 2);
        let count = 0;
        for (let ball of inventory) {
            count += Math.max(0, ball - mid + 1);
        }

        if (count >= orders) {
            right = right;
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    let ans = 0;
    let remainingOrders = orders;
    for (let ball of inventory) {
        if (ball >= left) {
            let count = Math.min(remainingOrders, ball - left + 1);
            ans = (ans + ((ball + ball - count + 1) % mod) * count / 2) % mod;
            remainingOrders -= count;
        }
    }

    ans = (ans + (remainingOrders * (left - 1)) % mod) % mod;

    return ans;
};