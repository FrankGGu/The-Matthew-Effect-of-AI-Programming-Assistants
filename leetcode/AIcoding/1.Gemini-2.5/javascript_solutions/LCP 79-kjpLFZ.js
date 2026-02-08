var isSubsequence = function(s, t) {
    let i = 0;
    let j = 0;

    while (i < s.length && j < t.length) {
        if (s[i] === t[j]) {
            j++;
        }
        i++;
    }

    return j === t.length;
};