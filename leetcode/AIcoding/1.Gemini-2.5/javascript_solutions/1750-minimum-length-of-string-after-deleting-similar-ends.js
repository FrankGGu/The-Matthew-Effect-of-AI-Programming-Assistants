var minimumLength = function(s) {
    let left = 0;
    let right = s.length - 1;

    while (left < right && s[left] === s[right]) {
        const char = s[left];

        // Move left pointer inwards while it points to the same character
        while (left <= right && s[left] === char) {
            left++;
        }

        // Move right pointer inwards while it points to the same character
        while (left <= right && s[right] === char) {
            right--;
        }
    }

    // The remaining length is right - left + 1.
    // If left > right, it means the string became empty, so length is 0.
    return Math.max(0, right - left + 1);
};