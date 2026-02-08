var minTime = function(time, m) {
    let left = 0;
    let right = time.reduce((a, b) => a + b, 0);

    const isPossible = (maxTime) => {
        let days = 1;
        let sum = 0;
        let max = 0;
        for (let t of time) {
            sum += t;
            max = Math.max(max, t);
            if (sum - max > maxTime) {
                days++;
                sum = t;
                max = t;
                if (days > m) return false;
            }
        }
        return days <= m;
    };

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (isPossible(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
};