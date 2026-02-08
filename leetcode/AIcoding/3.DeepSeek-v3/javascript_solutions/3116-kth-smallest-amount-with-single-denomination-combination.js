var findKthSmallest = function(coins, k) {
    let left = 1;
    let right = Math.min(...coins) * k;

    const count = (m) => {
        let total = 0;
        const n = coins.length;
        for (let mask = 1; mask < (1 << n); mask++) {
            let lcm = 1;
            let bits = 0;
            for (let i = 0; i < n; i++) {
                if (mask & (1 << i)) {
                    bits++;
                    lcm = lcm * coins[i] / gcd(lcm, coins[i]);
                    if (lcm > m) break;
                }
            }
            if (bits % 2 === 1) {
                total += Math.floor(m / lcm);
            } else {
                total -= Math.floor(m / lcm);
            }
        }
        return total;
    };

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (count(mid) < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
};

function gcd(a, b) {
    while (b !== 0) {
        const temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}