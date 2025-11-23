var countSubstrings = function(s) {
    let count = 0;
    const n = s.length;

    function expandAroundCenter(left, right) {
        let currentPalindromes = 0;
        while (left >= 0 && right < n && s[left] === s[right]) {
            currentPalindromes++;
            left--;
            right++;
        }
        return currentPalindromes;
    }

    for (let i = 0; i < n; i++) {
        // Odd length palindromes, center is s[i]
        count += expandAroundCenter(i, i);

        // Even length palindromes, center is s[i] and s[i+1]
        count += expandAroundCenter(i, i + 1);
    }

    return count;
};