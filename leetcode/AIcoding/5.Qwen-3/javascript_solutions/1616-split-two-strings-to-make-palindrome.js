function checkPalindromeFormation(s, t) {
    function isPalindrome(str) {
        let left = 0;
        let right = str.length - 1;
        while (left < right) {
            if (str[left] !== str[right]) return false;
            left++;
            right--;
        }
        return true;
    }

    function check(s1, s2) {
        let left = 0;
        let right = s1.length - 1;
        while (left < right && s1[left] === s2[right]) {
            left++;
            right--;
        }
        return isPalindrome(s1.slice(left, right + 1)) || isPalindrome(s2.slice(left, right + 1));
    }

    return check(s, t) || check(t, s);
}