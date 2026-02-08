var maximumRemovals = function(s, p, removable) {
    let left = 0, right = removable.length;

    const canForm = (k) => {
        const removed = new Set(removable.slice(0, k));
        let j = 0;

        for (let i = 0; i < s.length; i++) {
            if (removed.has(i)) continue;
            if (s[i] === p[j]) j++;
            if (j === p.length) return true;
        }
        return j === p.length;
    };

    while (left < right) {
        const mid = Math.floor((left + right + 1) / 2);
        if (canForm(mid)) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    return left;
};