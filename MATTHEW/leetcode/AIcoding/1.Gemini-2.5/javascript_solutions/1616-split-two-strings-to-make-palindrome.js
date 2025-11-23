var checkPalindromeFormation = function(a, b) {
    const n = a.length;

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

    const check = (s1, s2) => {
        let i = 0;
        let j = n - 1;

        while (i < j && s1[i] === s2[j]) {
            i++;
            j--;
        }

        return isPalindrome(s1, i, j) || isPalindrome(s2, i, j);
    };

    return check(a, b) || check(b, a);
};