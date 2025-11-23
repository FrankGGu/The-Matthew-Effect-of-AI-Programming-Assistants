var maxPower = function(stations, r, k) {
    let left = 0;
    let right = k + stations.reduce((a, b) => a + b, 0);
    let answer = 0;

    const check = (minPower) => {
        let extra = k;
        const power = [...stations];
        const n = power.length;
        const diff = new Array(n + 1).fill(0);
        let current = 0;

        for (let i = 0; i < n; i++) {
            current += diff[i];
            const total = power[i] + current;
            if (total < minPower) {
                const needed = minPower - total;
                if (needed > extra) {
                    return false;
                }
                extra -= needed;
                const end = Math.min(i + r, n - 1);
                diff[i] += needed;
                if (end + 1 < n) {
                    diff[end + 1] -= needed;
                }
                current += needed;
            }
        }
        return true;
    };

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (check(mid)) {
            answer = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return answer;
};