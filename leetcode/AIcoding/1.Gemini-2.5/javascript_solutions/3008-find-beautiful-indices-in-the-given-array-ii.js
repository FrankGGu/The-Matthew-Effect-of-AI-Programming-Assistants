var findBeautifulIndices = function(s, a, b, k) {
    function computeLPS(pattern) {
        const m = pattern.length;
        const lps = new Array(m).fill(0);
        let length = 0; // length of the previous longest prefix suffix
        let i = 1;
        while (i < m) {
            if (pattern[i] === pattern[length]) {
                length++;
                lps[i] = length;
                i++;
            } else {
                if (length !== 0) {
                    length = lps[length - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }
        return lps;
    }

    function KMPSearch(text, pattern, lps) {
        const n = text.length;
        const m = pattern.length;
        const occurrences = [];
        let i = 0; // index for text
        let j = 0; // index for pattern
        while (i < n) {
            if (pattern[j] === text[i]) {
                i++;
                j++;
            }
            if (j === m) {
                occurrences.push(i - j); // Pattern found at (i - j)
                j = lps[j - 1]; // Move j to find next possible match
            } else if (i < n && pattern[j] !== text[i]) {
                if (j !== 0) {
                    j = lps[j - 1];
                } else {
                    i++;
                }
            }
        }
        return occurrences;
    }

    const lpsA = computeLPS(a);
    const indicesA = KMPSearch(s, a, lpsA);

    const lpsB = computeLPS(b);
    const indicesB = KMPSearch(s, b, lpsB);

    const result = [];
    let ptrB = 0; // Pointer for indicesB

    for (const i of indicesA) {
        // Move ptrB to the first j such that j >= i - k
        while (ptrB < indicesB.length && indicesB[ptrB] < i - k) {
            ptrB++;
        }

        // Check if there is any j in the window [i - k, i + k]
        // If ptrB is within bounds and indicesB[ptrB] <= i + k, then i is a beautiful index.
        if (ptrB < indicesB.length && indicesB[ptrB] <= i + k) {
            result.push(i);
        }
    }

    return result;
};