var longestPalindrome = function(s) {
    if (s.length < 2) {
        return s;
    }

    let start = 0;
    let maxLength = 0;

    function expandAroundCenter(left, right) {
        while (left >= 0 && right < s.length && s[left] === s[right]) {
            left--;
            right++;
        }
        // At this point, s[left+1 ... right-1] is a palindrome.
        // Its length is (right-1) - (left+1) + 1 = right - left - 1.
        // Its start index is left + 1.
        if (right - left - 1 > maxLength) {
            maxLength = right - left - 1;
            start = left + 1;
        }
    }

    for (let i = 0; i < s.length; i++) {
        // Odd length palindromes (center is s[i])
        expandAroundCenter(i, i);
        // Even length palindromes (center is between s[i] and s[i+1])
        expandAroundCenter(i, i + 1);
    }

    return s.substring(start, start + maxLength);
};