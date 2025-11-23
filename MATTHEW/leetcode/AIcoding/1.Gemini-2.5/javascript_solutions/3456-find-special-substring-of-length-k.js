var findSpecialSubstringOfLengthK = function(s, k) {
    const n = s.length;

    if (k <= 0) {
        return 0;
    }
    if (k > n) {
        return 0;
    }

    const left = new Array(n);
    const right = new Array(n);

    if (n > 0) {
        left[0] = 1;
        for (let i = 1; i < n; i++) {
            if (s[i] === s[i - 1]) {
                left[i] = left[i - 1] + 1;
            } else {
                left[i] = 1;
            }
        }

        right[n - 1] = 1;
        for (let i = n - 2; i >= 0; i--) {
            if (s[i] === s[i + 1]) {
                right[i] = right[i + 1] + 1;
            } else {
                right[i] = 1;
            }
        }
    }

    let count = 0;

    for (let i = 0; i <= n - k; i++) {
        // Current substring is s[i...i+k-1]

        // Case 1: All characters in the substring are the same
        if (right[i] >= k) {
            count++;
            continue;
        }

        // Case 2: All characters are the same except for the middle one
        if (k % 2 === 1) {
            const midIndex = i + Math.floor(k / 2);
            const sideLength = Math.floor(k / 2);

            if (s[midIndex] !== s[i] &&
                right[i] >= sideLength &&
                left[i + k - 1] >= sideLength &&
                s[i] === s[midIndex + 1]) {
                count++;
            }
        }
    }

    return count;
};