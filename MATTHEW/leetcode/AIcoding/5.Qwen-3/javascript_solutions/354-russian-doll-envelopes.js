function maxEnvelopes(envelopes) {
    envelopes.sort((a, b) => a[0] === b[0] ? b[1] - a[1] : a[0] - b[0]);
    const dp = [];
    for (const [_, h] of envelopes) {
        let left = 0, right = dp.length;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (dp[mid] < h) left = mid + 1;
            else right = mid;
        }
        if (left === dp.length) dp.push(h);
        else dp[left] = h;
    }
    return dp.length;
}