var checkPalindromeFormation = function(a, b) {
    const check = (a, b) => {
        let left = 0, right = a.length - 1;
        while (left < right && a[left] === b[right]) {
            left++;
            right--;
        }
        return isPalindrome(a, left, right) || isPalindrome(b, left, right);
    };

    const isPalindrome = (s, left, right) => {
        while (left < right) {
            if (s[left] !== s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    };

    return check(a, b) || check(b, a);
};