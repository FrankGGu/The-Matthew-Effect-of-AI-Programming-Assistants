var longestPalindrome = function(s) {
    const count = {};
    for (const char of s) {
        count[char] = (count[char] || 0) + 1;
    }
    let length = 0;
    let oddFound = false;
    for (const char in count) {
        if (count[char] % 2 === 0) {
            length += count[char];
        } else {
            length += count[char] - 1;
            oddFound = true;
        }
    }
    return oddFound ? length + 1 : length;
};