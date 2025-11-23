var maxNumOfSubstrings = function(s) {
    const n = s.length;
    const first = new Array(n).fill(-1);
    const last = new Array(n).fill(-1);

    const charRange = new Map();

    for (let i = 0; i < n; i++) {
        if (!charRange.has(s[i])) charRange.set(s[i], [i, i]);
        charRange.get(s[i])[1] = i;
    }

    for (const [char, [start, end]] of charRange.entries()) {
        let minEnd = end;
        for (let i = start; i <= end; i++) {
            if (charRange.has(s[i])) {
                minEnd = Math.max(minEnd, charRange.get(s[i])[1]);
            }
        }
        first[start] = end;
        last[start] = minEnd;
    }

    const intervals = [];
    for (let i = 0; i < n; i++) {
        if (first[i] !== -1) {
            intervals.push([i, last[i]]);
        }
    }

    intervals.sort((a, b) => a[1] - b[1]);

    const result = [];
    let end = -1;

    for (const [start, currEnd] of intervals) {
        if (start > end) {
            result.push(s.substring(start, currEnd + 1));
            end = currEnd;
        }
    }

    return result;
};