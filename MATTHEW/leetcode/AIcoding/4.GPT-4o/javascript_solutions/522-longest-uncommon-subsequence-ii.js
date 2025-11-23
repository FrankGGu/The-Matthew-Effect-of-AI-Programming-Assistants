var findLUSlength = function(strs) {
    const isSubsequence = (s1, s2) => {
        let i = 0;
        for (let char of s2) {
            if (i < s1.length && char === s1[i]) i++;
        }
        return i === s1.length;
    };

    let maxLength = -1;

    for (let i = 0; i < strs.length; i++) {
        let isUncommon = true;
        for (let j = 0; j < strs.length; j++) {
            if (i !== j && isSubsequence(strs[i], strs[j])) {
                isUncommon = false;
                break;
            }
        }
        if (isUncommon) {
            maxLength = Math.max(maxLength, strs[i].length);
        }
    }

    return maxLength;
};