var minimumLength = function(s) {
    let left = 0;
    let right = s.length - 1;

    while (left < right && s[left] === s[right]) {
        let charToRemove = s[left];

        // Remove all occurrences of charToRemove from the prefix
        while (left <= right && s[left] === charToRemove) {
            left++;
        }

        // Remove all occurrences of charToRemove from the suffix
        while (left <= right && s[right] === charToRemove) {
            right--;
        }
    }

    return Math.max(0, right - left + 1);
};