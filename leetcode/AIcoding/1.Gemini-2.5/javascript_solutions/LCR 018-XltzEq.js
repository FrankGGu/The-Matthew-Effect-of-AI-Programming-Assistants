var isPalindrome = function(s) {
    const alphanumericString = s.replace(/[^a-zA-Z0-9]/g, '').toLowerCase();

    let left = 0;
    let right = alphanumericString.length - 1;

    while (left < right) {
        if (alphanumericString[left] !== alphanumericString[right]) {
            return false;
        }
        left++;
        right--;
    }

    return true;
};