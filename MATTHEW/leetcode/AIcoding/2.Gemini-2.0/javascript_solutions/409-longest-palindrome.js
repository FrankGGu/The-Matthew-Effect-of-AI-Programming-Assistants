var longestPalindrome = function(s) {
    const charCounts = {};
    for (const char of s) {
        charCounts[char] = (charCounts[char] || 0) + 1;
    }

    let length = 0;
    let hasOdd = false;

    for (const count of Object.values(charCounts)) {
        if (count % 2 === 0) {
            length += count;
        } else {
            length += count - 1;
            hasOdd = true;
        }
    }

    if (hasOdd) {
        length++;
    }

    return length;
};