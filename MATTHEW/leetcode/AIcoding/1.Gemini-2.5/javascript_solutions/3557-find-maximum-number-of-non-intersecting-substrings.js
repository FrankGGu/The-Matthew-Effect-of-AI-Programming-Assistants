var maxNumOfSubstrings = function(s) {
    const n = s.length;
    const first = new Array(26).fill(n);
    const last = new Array(26).fill(-1);

    for (let i = 0; i < n; i++) {
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        if (first[charCode] === n) {
            first[charCode] = i;
        }
        last[charCode] = i;
    }

    const validSubstrings = [];

    for (let i = 0; i < n; i++) {
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);

        if (first[charCode] !== i) {
            continue;
        }

        let currentStart = i;
        let currentEnd = last[charCode];
        let isValid = true;

        for (let j = currentStart; j <= currentEnd; j++) {
            const innerCharCode = s.charCodeAt(j) - 'a'.charCodeAt(0);

            if (first[innerCharCode] < currentStart) {
                isValid = false;
                break;
            }

            currentEnd = Math.max(currentEnd, last[innerCharCode]);
        }

        if (isValid) {
            validSubstrings.push([currentStart, currentEnd]);
        }
    }

    validSubstrings.sort((a, b) => {
        if (a[1] !== b[1]) {
            return a[1] - b[1];
        }
        return (a[1] - a[0]) - (b[1] - b[0]);
    });

    const result = [];
    let lastEnd = -1;

    for (const [start, end] of validSubstrings) {
        if (start > lastEnd) {
            result.push(s.substring(start, end + 1));
            lastEnd = end;
        }
    }

    return result;
};