var smallestGoodBase = function(n) {
    const N = BigInt(n);

    const check = (k, m, targetN) => {
        let currentSum = 0n;
        let currentTerm = 1n;

        for (let i = 0; i <= m; i++) {
            currentSum += currentTerm;
            if (currentSum > targetN) {
                return 1;
            }
            if (i < m) {
                if (currentTerm > targetN / k) {
                    return 1;
                }
                currentTerm *= k;
            }
        }
        if (currentSum === targetN) {
            return 0;
        } else if (currentSum < targetN) {
            return -1;
        } else {
            return 1;
        }
    };

    for (let m = Math.floor(Math.log2(Number(N))); m >= 1; m--) {
        let low = 2n;
        let high = BigInt(Math.pow(Number(N), 1 / m)) + 2n;

        while (low <= high) {
            const mid = low + (high - low) / 2n;
            if (mid < 2n) {
                low = 2n;
                continue;
            }

            const result = check(mid, m, N);

            if (result === 0) {
                return mid.toString();
            } else if (result === -1) {
                low = mid + 1n;
            } else {
                high = mid - 1n;
            }
        }
    }

    return (N - 1n).toString();
};