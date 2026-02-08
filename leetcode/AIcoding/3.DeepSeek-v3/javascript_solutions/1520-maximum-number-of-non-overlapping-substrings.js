var maxNumOfSubstrings = function(s) {
    const first = new Array(26).fill(Infinity);
    const last = new Array(26).fill(-Infinity);

    for (let i = 0; i < s.length; i++) {
        const code = s.charCodeAt(i) - 97;
        first[code] = Math.min(first[code], i);
        last[code] = Math.max(last[code], i);
    }

    const intervals = [];
    for (let i = 0; i < 26; i++) {
        if (first[i] !== Infinity) {
            let left = first[i];
            let right = last[i];
            let valid = true;
            for (let j = left; j <= right; j++) {
                const code = s.charCodeAt(j) - 97;
                if (first[code] < left) {
                    valid = false;
                    break;
                }
                right = Math.max(right, last[code]);
            }
            if (valid) {
                intervals.push([left, right]);
            }
        }
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