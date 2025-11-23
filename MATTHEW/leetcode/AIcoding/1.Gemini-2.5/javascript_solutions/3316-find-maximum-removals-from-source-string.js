var maximumRemovals = function(s, p, removable) {
    const n = s.length;
    const m = p.length;
    const kMax = removable.length;

    const check = (k) => {
        const removed = new Set();
        for (let i = 0; i < k; i++) {
            removed.add(removable[i]);
        }

        let sPointer = 0;
        let pPointer = 0;

        while (sPointer < n && pPointer < m) {
            if (removed.has(sPointer)) {
                sPointer++;
                continue;
            }
            if (s[sPointer] === p[pPointer]) {
                pPointer++;
            }
            sPointer++;
        }

        return pPointer === m;
    };

    let low = 0;
    let high = kMax;
    let ans = 0;

    while (low <= high) {
        const mid = Math.floor(low + (high - low) / 2);
        if (check(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};