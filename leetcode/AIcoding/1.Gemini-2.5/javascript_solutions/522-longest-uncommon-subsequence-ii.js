var findLUSlength = function(strs) {
    const isSubsequence = (s1, s2) => {
        let i = 0;
        let j = 0;
        while (i < s1.length && j < s2.length) {
            if (s1[i] === s2[j]) {
                i++;
            }
            j++;
        }
        return i === s1.length;
    };

    let maxLength = -1;

    for (let i = 0; i < strs.length; i++) {
        let currentStr = strs[i];
        let isUncommon = true;

        for (let j = 0; j < strs.length; j++) {
            if (i === j) {
                continue;
            }

            if (isSubsequence(currentStr, strs[j])) {
                isUncommon = false;
                break;
            }
        }

        if (isUncommon) {
            maxLength = Math.max(maxLength, currentStr.length);
        }
    }

    return maxLength;
};