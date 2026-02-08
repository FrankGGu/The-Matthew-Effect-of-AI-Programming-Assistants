var countSubstrings = function(s) {
    let count = 0;

    const isPalindrome = (l, r) => {
        while (l >= 0 && r < s.length && s[l] === s[r]) {
            count++;
            l--;
            r++;
        }
    };

    for (let i = 0; i < s.length; i++) {
        isPalindrome(i, i); // Odd length palindromes
        isPalindrome(i, i + 1); // Even length palindromes
    }

    return count;
};