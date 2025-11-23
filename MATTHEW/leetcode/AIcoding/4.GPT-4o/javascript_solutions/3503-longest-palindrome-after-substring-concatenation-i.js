function longestPalindrome(s) {
    let maxLen = 0;
    let n = s.length;

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            let substring = s.slice(i, j + 1);
            if (isPalindrome(substring)) {
                maxLen = Math.max(maxLen, substring.length);
            }
        }
    }

    return maxLen;
}

function isPalindrome(str) {
    let left = 0;
    let right = str.length - 1;
    while (left < right) {
        if (str[left] !== str[right]) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}