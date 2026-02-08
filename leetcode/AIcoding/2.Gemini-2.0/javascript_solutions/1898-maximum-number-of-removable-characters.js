var maximumRemovals = function(s, p, removable) {
    let left = 0;
    let right = removable.length;
    let ans = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const removed = new Set(removable.slice(0, mid));
        let t = "";
        for (let i = 0; i < s.length; i++) {
            if (!removed.has(i)) {
                t += s[i];
            }
        }

        let i = 0;
        let j = 0;
        while (i < t.length && j < p.length) {
            if (t[i] === p[j]) {
                j++;
            }
            i++;
        }

        if (j === p.length) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
};