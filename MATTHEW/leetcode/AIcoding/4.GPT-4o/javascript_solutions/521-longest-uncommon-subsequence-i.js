var findLUSlength = function(strs) {
    let maxLength = -1;

    for (let i = 0; i < strs.length; i++) {
        let isSubsequence = false;

        for (let j = 0; j < strs.length; j++) {
            if (i !== j && isSubsequenceOf(strs[i], strs[j])) {
                isSubsequence = true;
                break;
            }
        }

        if (!isSubsequence) {
            maxLength = Math.max(maxLength, strs[i].length);
        }
    }

    return maxLength;
};

function isSubsequenceOf(s1, s2) {
    let i = 0, j = 0;

    while (i < s1.length && j < s2.length) {
        if (s1[i] === s2[j]) {
            i++;
        }
        j++;
    }

    return i === s1.length;
}