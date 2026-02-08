function maximumRemovals(s, p, removable) {
    let left = 0, right = removable.length;

    while (left < right) {
        const mid = Math.floor((left + right + 1) / 2);
        if (canForm(s, p, removable, mid)) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    return left;
}

function canForm(s, p, removable, k) {
    const removed = new Set(removable.slice(0, k));
    let j = 0;

    for (let i = 0; i < s.length; i++) {
        if (!removed.has(i) && s[i] === p[j]) {
            j++;
            if (j === p.length) {
                return true;
            }
        }
    }

    return j === p.length;
}