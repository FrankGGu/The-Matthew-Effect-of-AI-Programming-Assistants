function minimumLength(s) {
    let left = 0;
    let right = s.length - 1;

    while (left < right && s[left] === s[right]) {
        while (left < right && s[left] === s[left + 1]) {
            left++;
        }
        while (left < right && s[right] === s[right - 1]) {
            right--;
        }
        left++;
        right--;
    }

    return right - left + 1;
}