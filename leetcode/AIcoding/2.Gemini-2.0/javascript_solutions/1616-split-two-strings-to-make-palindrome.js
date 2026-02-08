var checkPalindromeFormation = function(a, b) {
    const n = a.length;

    function isPalindrome(s, start, end) {
        while (start < end) {
            if (s[start] !== s[end]) {
                return false;
            }
            start++;
            end--;
        }
        return true;
    }

    function check(str1, str2) {
        let i = 0;
        let j = n - 1;
        while (i < j && str1[i] === str2[j]) {
            i++;
            j--;
        }
        return isPalindrome(str1, i, j) || isPalindrome(str2, i, j);
    }

    return check(a, b) || check(b, a);
};