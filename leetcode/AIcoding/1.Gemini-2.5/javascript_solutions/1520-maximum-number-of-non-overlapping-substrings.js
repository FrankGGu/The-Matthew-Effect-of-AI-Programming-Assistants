var maxNumOfSubstrings = function(s) {
    const n = s.length;
    const first = new Array(26).fill(Infinity);
    const last = new Array(26).fill(-1);

    for (let i = 0; i < n; i++) {
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        first[charCode] = Math.min(first[charCode], i);
        last[charCode] = Math.max(last[charCode], i);
    }

    const validSubstrings = [];

    for (let i = 0; i < n; i++) {
        const charCodeI = s.charCodeAt(i) - 'a'.charCodeAt(0);

        // Only consider `i` as a potential start if it's the first occurrence of `s[i]`
        // This ensures we find the leftmost possible start for a valid substring containing `s[i]`.
        if (i === first[charCodeI]) {
            let currentStart = i;
            let currentEnd = last[charCodeI];
            let isValid = true;

            // Iterate through the current potential substring [currentStart, currentEnd]
            // to expand currentEnd if necessary and check the `first` occurrence condition.
            for (let k = currentStart; k <= currentEnd; k++) {
                const charCodeK = s.charCodeAt(k) - 'a'.charCodeAt(0);

                // If any character `s[k]` within the range `[currentStart, currentEnd]`
                // has its first occurrence before `currentStart`, then `s[currentStart...currentEnd]`
                // cannot be a valid substring.
                if (first[charCodeK] < currentStart) {
                    isValid = false;
                    break;
                }
                // Expand `currentEnd` to cover the last occurrence of `s[k]` if it extends beyond.
                currentEnd = Math.max(currentEnd, last[charCodeK]);
            }

            if (isValid) {
                validSubstrings.push([currentStart, currentEnd]);
            }
        }
    }

    // Sort valid substrings for greedy selection:
    // 1. By end position (ascending)
    // 2. By length (ascending) for tie-breaking to minimize total length
    validSubstrings.sort((a, b) => {
        if (a[1] !== b[1]) {
            return a[1] - b[1];
        }
        return (a[1] - a[0]) - (b[1] - b[0]);
    });

    const result = [];
    let prevEnd = -1;

    for (const [start, end] of validSubstrings) {
        // If the current substring does not overlap with the previously selected one
        if (start > prevEnd) {
            result.push(s.substring(start, end + 1));
            prevEnd = end;
        }
    }

    return result;
};