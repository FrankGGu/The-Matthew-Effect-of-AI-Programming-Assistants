var maxNumOfSubstrings = function(s) {
    const first = new Array(26).fill(Infinity);
    const last = new Array(26).fill(-1);
    const n = s.length;

    for (let i = 0; i < n; i++) {
        const c = s.charCodeAt(i) - 97;
        first[c] = Math.min(first[c], i);
        last[c] = Math.max(last[c], i);
    }

    const intervals = [];
    for (let i = 0; i < 26; i++) {
        if (first[i] === Infinity) continue;
        let left = first[i];
        let right = last[i];
        let valid = true;

        for (let j = left; j <= right; j++) {
            const c = s.charCodeAt(j) - 97;
            if (first[c] < left) {
                valid = false;
                break;
            }
            right = Math.max(right, last[c]);
        }

        if (valid) {
            intervals.push([left, right]);
        }
    }

    intervals.sort((a, b) => a[1] - b[1]);

    const res = [];
    let prevEnd = -1;
    for (const [start, end] of intervals) {
        if (start > prevEnd) {
            res.push(s.substring(start, end + 1));
            prevEnd = end;
        }
    }

    return res;
};