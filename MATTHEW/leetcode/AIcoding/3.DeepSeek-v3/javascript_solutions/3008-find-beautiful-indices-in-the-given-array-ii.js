var beautifulIndices = function(s, a, b, k) {
    const findIndices = (str, pattern) => {
        const indices = [];
        const len = pattern.length;
        if (len === 0) return indices;
        const lps = computeLPSArray(pattern);
        let i = 0, j = 0;
        while (i < str.length) {
            if (str[i] === pattern[j]) {
                i++;
                j++;
                if (j === len) {
                    indices.push(i - j);
                    j = lps[j - 1];
                }
            } else {
                if (j !== 0) {
                    j = lps[j - 1];
                } else {
                    i++;
                }
            }
        }
        return indices;
    };

    const computeLPSArray = (pattern) => {
        const lps = new Array(pattern.length).fill(0);
        let len = 0, i = 1;
        while (i < pattern.length) {
            if (pattern[i] === pattern[len]) {
                len++;
                lps[i] = len;
                i++;
            } else {
                if (len !== 0) {
                    len = lps[len - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }
        return lps;
    };

    const aIndices = findIndices(s, a);
    const bIndices = findIndices(s, b);
    const result = [];
    let ptr = 0;

    for (const i of aIndices) {
        while (ptr < bIndices.length && bIndices[ptr] < i - k) {
            ptr++;
        }
        if (ptr < bIndices.length && Math.abs(bIndices[ptr] - i) <= k) {
            result.push(i);
        }
    }

    return result;
};