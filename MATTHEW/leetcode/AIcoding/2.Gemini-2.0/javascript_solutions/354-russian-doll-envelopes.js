var maxEnvelopes = function(envelopes) {
    envelopes.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        } else {
            return b[1] - a[1];
        }
    });

    const dp = [];
    for (const envelope of envelopes) {
        const height = envelope[1];
        let left = 0;
        let right = dp.length;

        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (dp[mid] < height) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        if (left === dp.length) {
            dp.push(height);
        } else {
            dp[left] = height;
        }
    }

    return dp.length;
};