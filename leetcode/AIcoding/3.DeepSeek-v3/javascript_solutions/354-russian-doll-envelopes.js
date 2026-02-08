var maxEnvelopes = function(envelopes) {
    if (envelopes.length === 0) return 0;

    envelopes.sort((a, b) => {
        if (a[0] === b[0]) {
            return b[1] - a[1];
        } else {
            return a[0] - b[0];
        }
    });

    const dp = [];
    let len = 0;

    for (const envelope of envelopes) {
        let left = 0, right = len;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (dp[mid] < envelope[1]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        dp[left] = envelope[1];
        if (left === len) len++;
    }

    return len;
};