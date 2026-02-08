var maxNumOfSubstrings = function(s) {
    const n = s.length;
    const first = new Array(26).fill(-1);
    const last = new Array(26).fill(-1);

    for (let i = 0; i < n; i++) {
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        if (first[charCode] === -1) {
            first[charCode] = i;
        }
        last[charCode] = i;
    }

    const intervals = [];
    for (let i = 0; i < 26; i++) {
        if (first[i] === -1) continue;
        let start = first[i];
        let end = last[i];
        let j = start;
        while (j <= end) {
            const charCode = s.charCodeAt(j) - 'a'.charCodeAt(0);
            if (first[charCode] < start) {
                start = first[charCode];
                j = start;
                continue;
            }
            if (last[charCode] > end) {
                end = last[charCode];
            }
            j++;
        }
        intervals.push([start, end]);
    }

    intervals.sort((a, b) => a[1] - b[1]);

    const result = [];
    let prevEnd = -1;
    for (const [start, end] of intervals) {
        if (start > prevEnd) {
            result.push(s.substring(start, end + 1));
            prevEnd = end;
        }
    }

    return result;
};