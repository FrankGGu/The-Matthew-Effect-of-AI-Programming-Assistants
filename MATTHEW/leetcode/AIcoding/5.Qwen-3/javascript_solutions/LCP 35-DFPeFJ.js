function minDifference(stations, k) {
    const n = stations.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + stations[i];
    }

    const getDiff = (mid) => {
        let res = 0;
        let prev = 0;
        for (let i = 1; i <= n; i++) {
            if (prefix[i] - prefix[prev] > mid) {
                res++;
                prev = i - 1;
            }
        }
        return res;
    };

    let left = 0;
    let right = prefix[n];
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (getDiff(mid) <= k) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}