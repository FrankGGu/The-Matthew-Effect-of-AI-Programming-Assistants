var shortestPalindrome = function(s) {
    const rev = s.split('').reverse().join('');
    const combined = s + '#' + rev;
    const n = combined.length;
    const lps = new Array(n).fill(0);

    for (let i = 1; i < n; i++) {
        let j = lps[i - 1];
        while (j > 0 && combined[i] !== combined[j]) {
            j = lps[j - 1];
        }
        if (combined[i] === combined[j]) {
            j++;
        }
        lps[i] = j;
    }

    const maxLen = lps[n - 1];
    const toAdd = s.substring(maxLen).split('').reverse().join('');
    return toAdd + s;
};