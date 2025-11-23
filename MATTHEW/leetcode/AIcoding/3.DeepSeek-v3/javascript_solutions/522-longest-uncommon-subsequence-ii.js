var findLUSlength = function(strs) {
    const isSubsequence = (a, b) => {
        let i = 0, j = 0;
        while (i < a.length && j < b.length) {
            if (a[i] === b[j]) {
                i++;
            }
            j++;
        }
        return i === a.length;
    };

    let maxLen = -1;
    for (let i = 0; i < strs.length; i++) {
        let current = strs[i];
        let isCandidate = true;
        for (let j = 0; j < strs.length; j++) {
            if (i !== j && isSubsequence(current, strs[j])) {
                isCandidate = false;
                break;
            }
        }
        if (isCandidate) {
            maxLen = Math.max(maxLen, current.length);
        }
    }
    return maxLen;
};