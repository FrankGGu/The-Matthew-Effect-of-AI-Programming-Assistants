var minimumLength = function(s) {
    let left = 0;
    let right = s.length - 1;

    while (left < right && s[left] === s[right]) {
        const current = s[left];
        while (left <= right && s[left] === current) {
            left++;
        }
        while (left <= right && s[right] === current) {
            right--;
        }
    }

    return right - left + 1;
};