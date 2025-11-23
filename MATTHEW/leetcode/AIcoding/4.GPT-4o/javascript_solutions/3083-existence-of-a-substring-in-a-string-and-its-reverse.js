var isSubsequence = function(s, t) {
    let m = s.length, n = t.length;
    let j = 0;

    for (let i = 0; i < n && j < m; i++) {
        if (t[i] === s[j]) {
            j++;
        }
    }

    return j === m;
};

var isReversedSubsequence = function(s, t) {
    let reversedS = s.split('').reverse().join('');
    return isSubsequence(reversedS, t);
};

var isSubstringAndReverseExist = function(s, t) {
    return isSubsequence(s, t) || isReversedSubsequence(s, t);
};