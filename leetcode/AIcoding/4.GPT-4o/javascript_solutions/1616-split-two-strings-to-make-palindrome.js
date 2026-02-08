var checkPalindromeFormation = function(a, b) {
    const isPalindrome = (s) => {
        let left = 0, right = s.length - 1;
        while (left < right) {
            if (s[left] !== s[right]) return false;
            left++;
            right--;
        }
        return true;
    };

    const canFormPalindrome = (s1, s2) => {
        let left = 0, right = s1.length - 1;
        while (left < right) {
            if (s1[left] !== s2[right]) {
                return isPalindrome(s1.slice(left, right)) || isPalindrome(s2.slice(left, right));
            }
            left++;
            right--;
        }
        return true;
    };

    return canFormPalindrome(a, b) || canFormPalindrome(b, a);
};