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

        let left = first[i];
        let right = last[i];
        let j = left;

        while (j <= right) {
            const charCode = s.charCodeAt(j) - 'a'.charCodeAt(0);
            right = Math.max(right, last[charCode]);
            j++;
        }

        intervals.push([left, right]);
    }

    intervals.sort((a, b) => a[1] - b[1]);

    const result = [];
    let end = -1;

    for (const interval of intervals) {
        if (interval[0] > end) {
            result.push(s.substring(interval[0], interval[1] + 1));
            end = interval[1];
        }
    }

    return result;
};