var longestSemiRepetitiveSubstring = function(s) {
    const n = s.length;
    if (n <= 2) {
        return n;
    }

    let maxLength = 0;
    let left = 0;
    let adjacentPairs = 0; // Counts pairs of adjacent identical characters in the current window s[left...right]

    for (let right = 0; right < n; right++) {
        // If the current character forms an adjacent pair with the previous character
        if (right > 0 && s[right] === s[right - 1]) {
            adjacentPairs++;
        }

        // If we have more than one adjacent pair, shrink the window from the left
        while (adjacentPairs > 1) {
            // If the character at 'left' was part of an adjacent pair s[left]s[left+1]
            if (s[left] === s[left + 1]) {
                adjacentPairs--;
            }
            left++;
        }

        // The current window s[left...right] is semi-repetitive
        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
};