var maximumRemovals = function(s, p, removable) {
    let left = 0;
    let right = removable.length;
    let result = 0;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (isSubsequence(s, p, removable, mid)) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
};

function isSubsequence(s, p, removable, k) {
    const removed = new Set(removable.slice(0, k));
    let i = 0;
    let j = 0;

    while (i < s.length && j < p.length) {
        if (!removed.has(i) && s[i] === p[j]) {
            j++;
        }
        i++;
    }

    return j === p.length;
}