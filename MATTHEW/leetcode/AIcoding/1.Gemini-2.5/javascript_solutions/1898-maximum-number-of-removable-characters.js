var maximumRemovals = function(s, p, removable) {
    const n = s.length;
    const m = p.length;
    const kMax = removable.length;

    const check = (count) => {
        const isRemoved = new Array(n).fill(false);
        for (let i = 0; i < count; i++) {
            isRemoved[removable[i]] = true;
        }

        let sPtr = 0;
        let pPtr = 0;

        while (sPtr < n && pPtr < m) {
            if (!isRemoved[sPtr] && s[sPtr] === p[pPtr]) {
                pPtr++;
            }
            sPtr++;
        }
        return pPtr === m;
    };

    let low = 0;
    let high = kMax;
    let ans = 0;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (check(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};