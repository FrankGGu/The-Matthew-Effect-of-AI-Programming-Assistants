var removePalindromeSub = function(s) {
    if (s.length === 0) {
        return 0;
    }

    let left = 0;
    let right = s.length - 1;

    while (left < right) {
        if (s[left] !== s[right]) {
            return 2;
        }
        left++;
        right--;
    }

    return 1;
};