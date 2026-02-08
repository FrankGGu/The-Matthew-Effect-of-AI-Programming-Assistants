var findLUSlength = function(strs) {
    function isSubsequence(s, t) {
        let i = 0;
        let j = 0;
        while (i < s.length && j < t.length) {
            if (s[i] === t[j]) {
                i++;
            }
            j++;
        }
        return i === s.length;
    }

    let ans = -1;
    for (let i = 0; i < strs.length; i++) {
        let isUncommon = true;
        for (let j = 0; j < strs.length; j++) {
            if (i !== j && isSubsequence(strs[i], strs[j])) {
                isUncommon = false;
                break;
            }
        }
        if (isUncommon) {
            ans = Math.max(ans, strs[i].length);
        }
    }
    return ans;
};