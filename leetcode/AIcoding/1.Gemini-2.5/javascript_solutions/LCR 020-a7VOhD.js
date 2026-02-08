var countSubstrings = function(s) {
    let count = 0;
    const n = s.length;

    function expandAroundCenter(left, right) {
        while (left >= 0 && right < n && s[left] === s[right]) {
            count++;
            left--;
            right++;
        }
    }

    for (let i = 0; i < n; i++) {
        // Odd length palindromes, center is s[i]
        expandAroundCenter(i, i);
        // Even length palindromes, center is between s[i] and s[i+1]
        expandAroundCenter(i, i + 1);
    }

    return count;
};