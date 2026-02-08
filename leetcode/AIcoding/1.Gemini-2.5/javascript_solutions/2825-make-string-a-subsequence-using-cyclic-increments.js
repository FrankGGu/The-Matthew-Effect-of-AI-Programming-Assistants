var canMakeSubsequence = function(str1, str2) {
    let j = 0;

    function charCanMatch(c1, c2) {
        const val1 = c1.charCodeAt(0) - 97;
        const val2 = c2.charCodeAt(0) - 97;
        const diff = (val2 - val1 + 26) % 26;
        return diff <= 2;
    }

    for (let i = 0; i < str1.length; i++) {
        if (j < str2.length) {
            if (charCanMatch(str1[i], str2[j])) {
                j++;
            }
        } else {
            break;
        }
    }

    return j === str2.length;
};