var checkPalindromeFormation = function(a, b) {
    const isPalindrome = (s, left, right) => {
        while (left < right) {
            if (s[left] !== s[right]) return false;
            left++;
            right--;
        }
        return true;
    };

    const n = a.length;
    for (let i = 0; i < n; i++) {
        if (a[i] !== b[n - 1 - i]) {
            return isPalindrome(a, i, n - 1 - i) || isPalindrome(b, i, n - 1 - i);
        }
    }
    return true;
};