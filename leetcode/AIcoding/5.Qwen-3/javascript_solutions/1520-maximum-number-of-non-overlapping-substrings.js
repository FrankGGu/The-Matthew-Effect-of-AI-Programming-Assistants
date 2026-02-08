function maxNumOfNonOverlappingSubstrings(s) {
    const count = new Array(26).fill(0);
    const first = new Array(26).fill(-1);
    const last = new Array(26).fill(-1);

    for (let i = 0; i < s.length; i++) {
        const c = s[i];
        const idx = c.charCodeAt(0) - 'a'.charCodeAt(0);
        count[idx]++;
        if (first[idx] === -1) first[idx] = i;
        last[idx] = i;
    }

    const intervals = [];
    for (let i = 0; i < 26; i++) {
        if (count[i] > 0) {
            intervals.push([first[i], last[i]]);
        }
    }

    intervals.sort((a, b) => a[0] - b[0]);

    let result = 0;
    let prevEnd = -1;

    for (const [start, end] of intervals) {
        if (start > prevEnd) {
            result++;
            prevEnd = end;
        }
    }

    return result;
}