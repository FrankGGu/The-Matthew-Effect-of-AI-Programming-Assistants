function maxProfit(prices, inventory, k) {
    const MOD = 10 ** 9 + 7;
    const n = prices.length;
    const pairs = [];
    for (let i = 0; i < n; i++) {
        pairs.push([prices[i], inventory[i]]);
    }
    pairs.sort((a, b) => b[0] - a[0]);

    let res = 0;
    let i = 0;
    while (k > 0 && i < n) {
        const [price, count] = pairs[i];
        if (count === 0) {
            i++;
            continue;
        }
        const nextPrice = i + 1 < n ? pairs[i + 1][0] : 0;
        const maxPossible = Math.min(count, (price - nextPrice) * (price + nextPrice + 1) / 2);
        if (k >= count) {
            res += (price * count - (price - count + 1) * count / 2) % MOD;
            k -= count;
            i++;
        } else {
            const steps = Math.floor((price - nextPrice) * (price + nextPrice + 1) / 2);
            if (steps <= k) {
                res += (price * k - (price - k + 1) * k / 2) % MOD;
                k = 0;
            } else {
                let low = price;
                let high = nextPrice + 1;
                while (low > high) {
                    const mid = Math.floor((low + high) / 2);
                    const total = (price + mid) * (price - mid + 1) / 2;
                    if (total <= k) {
                        high = mid - 1;
                    } else {
                        low = mid + 1;
                    }
                }
                res += (price * (k - (price - low + 1) * (price + low) / 2) - (price - low + 1) * (price + low) / 2) % MOD;
                k = 0;
            }
            break;
        }
    }
    return res % MOD;
}