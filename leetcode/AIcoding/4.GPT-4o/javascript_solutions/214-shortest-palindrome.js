var shortestPalindrome = function(s) {
    var newS = s + '#' + s.split('').reverse().join('');
    var lps = new Array(newS.length).fill(0);
    for (let i = 1; i < newS.length; i++) {
        let j = lps[i - 1];
        while (j > 0 && newS[i] !== newS[j]) {
            j = lps[j - 1];
        }
        if (newS[i] === newS[j]) {
            j++;
        }
        lps[i] = j;
    }
    return s.slice(lps[lps.length - 1]).split('').reverse().join('') + s;
};