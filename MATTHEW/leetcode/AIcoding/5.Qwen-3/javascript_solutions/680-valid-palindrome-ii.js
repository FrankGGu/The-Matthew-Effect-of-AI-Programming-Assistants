function isPalindrome(s) {
    let left = 0;
    let right = s.length - 1;

    while (left < right) {
        if (s[left] !== s[right]) {
            return isPalindromeHelper(s, left + 1, right) || isPalindromeHelper(s, left, right - 1);
        }
        left++;
        right--;
    }
    return true;
}

function isPalindromeHelper(s, left, right) {
    while (left < right) {
        if (s[left] !== s[right]) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}