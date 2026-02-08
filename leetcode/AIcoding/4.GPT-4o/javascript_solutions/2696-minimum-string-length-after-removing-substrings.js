var minimumLength = function(s) {
    let left = 0, right = s.length - 1;
    while (left < right) {
        if (s[left] === s[right]) {
            const char = s[left];
            while (left <= right && s[left] === char) left++;
            while (left <= right && s[right] === char) right--;
        } else {
            break;
        }
    }
    return right - left + 1;
};