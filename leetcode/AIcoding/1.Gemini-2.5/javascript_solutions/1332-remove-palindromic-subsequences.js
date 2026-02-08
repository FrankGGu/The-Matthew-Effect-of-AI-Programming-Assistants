var removePalindromeSub = function(s) {
    if (s.length === 0) {
        return 0;
    }

    let left = 0;
    let right = s.length - 1;
    let isPalindrome = true;

    while (left < right) {
        if (s[left] !== s[right]) {
            isPalindrome = false;
            break;
        }
        left++;
        right--;
    }

    if (isPalindrome) {
        return 1;
    } else {
        return 2;
    }
};