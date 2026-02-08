var maxProfit = function(products, orders) {
    products.sort((a, b) => b - a);
    let left = 0, right = products[0];
    let ans = 0;
    const MOD = 10**9 + 7;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let count = 0;
        for (let p of products) {
            count += Math.max(0, p - mid + 1);
        }

        if (count >= orders) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    for (let p of products) {
        if (p > right) {
            let take = Math.min(p - right, orders);
            ans = (ans + (p + p - take + 1) * take / 2) % MOD;
            orders -= take;
        }
    }

    ans = (ans + right * orders) % MOD;

    return ans;
};