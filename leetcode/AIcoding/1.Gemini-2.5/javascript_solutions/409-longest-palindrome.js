var longestPalindrome = function(s) {
    const charCounts = new Map();
    for (const char of s) {
        charCounts.set(char, (charCounts.get(char) || 0) + 1);
    }

    let length = 0;
    let hasOdd = false;

    for (const count of charCounts.values()) {
        if (count % 2 === 0) {
            length += count;
        } else {
            length += count - 1;
            hasOdd = true;
        }
    }

    if (hasOdd) {
        length += 1;
    }

    return length;
};