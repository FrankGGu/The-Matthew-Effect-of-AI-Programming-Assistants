var longestCommonPrefixOfKStringsAfterRemoval = function(strs, k) {
    const n = strs.length;

    if (k === 0) {
        return 0;
    }
    if (k > n) {
        return 0;
    }
    if (n === 0) {
        return 0;
    }

    let maxPossibleLen = 0;
    for (const s of strs) {
        maxPossibleLen = Math.max(maxPossibleLen, s.length);
    }

    let low = 0;
    let high = maxPossibleLen;
    let ans = 0;

    while (low <= high) {
        const mid = Math.floor((low + high) / 2);

        if (check(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;

    function check(len) {
        const prefixCounts = new Map();
        for (const s of strs) {
            if (s.length >= len) {
                const prefix = s.substring(0, len);
                prefixCounts.set(prefix, (prefixCounts.get(prefix) || 0) + 1);
            }
        }

        for (const count of prefixCounts.values()) {
            if (count >= k) {
                return true;
            }
        }
        return false;
    }
};