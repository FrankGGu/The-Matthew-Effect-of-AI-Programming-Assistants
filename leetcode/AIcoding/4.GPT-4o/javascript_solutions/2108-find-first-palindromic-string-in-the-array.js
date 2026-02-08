var isPalindrome = function(s) {
    let left = 0;
    let right = s.length - 1;
    while (left < right) {
        if (s[left] !== s[right]) return false;
        left++;
        right--;
    }
    return true;
};

var firstPalindrome = function(words) {
    for (const word of words) {
        if (isPalindrome(word)) {
            return word;
        }
    }
    return "";
};