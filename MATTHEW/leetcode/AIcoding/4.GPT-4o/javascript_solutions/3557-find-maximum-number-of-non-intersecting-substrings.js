var maxNumOfSubstrings = function(s) {
    const n = s.length;
    const first = new Array(n).fill(0);
    const last = new Array(n).fill(0);

    const map = new Map();

    for (let i = 0; i < n; i++) {
        const c = s[i];
        if (!map.has(c)) {
            map.set(c, [i, i]);
        } else {
            const [start, end] = map.get(c);
            map.set(c, [start, i]);
        }
    }

    for (const [c, [start, end]] of map) {
        first[start] = end;
        last[end] = start;
    }

    const intervals = [];
    for (let i = 0; i < n; i++) {
        if (first[i] > 0) {
            intervals.push([i, first[i]]);
        }
    }

    intervals.sort((a, b) => a[1] - b[1]);

    const result = [];
    let lastEnd = -1;

    for (const [start, end] of intervals) {
        if (start >= lastEnd) {
            result.push(s.slice(start, end + 1));
            lastEnd = end;
        }
    }

    return result;
};