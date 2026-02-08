var maxNumberOfAlloys = function(n, k, budget, composition, stock, cost) {
    let low = 0;
    let high = 2 * 10 ** 8;
    let ans = 0;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        let possible = false;

        for (let i = 0; i < k; i++) {
            let moneyNeeded = 0;
            for (let j = 0; j < n; j++) {
                let needed = composition[i][j] * mid - stock[j];
                if (needed > 0) {
                    moneyNeeded += needed * cost[j];
                }
            }
            if (moneyNeeded <= budget) {
                possible = true;
                break;
            }
        }

        if (possible) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};