var longestBalancedSubstring = function(s) {
    let maxLen = 0;
    let i = 0;
    const n = s.length;

    while (i < n) {
        // Skip any leading '1's, as a balanced substring must start with '0'
        while (i < n && s[i] === '1') {
            i++;
        }

        if (i === n) {
            break; // Reached the end of the string
        }

        // Count consecutive '0's
        let count0 = 0;
        while (i < n && s[i] === '0') {
            count0++;
            i++;
        }

        if (i === n) {
            break; // Reached the end of the string after '0's, no '1's to follow
        }

        // Count consecutive '1's
        let count1 = 0;
        while (i < n && s[i] === '1') {
            count1++;
            i++;
        }

        // A balanced substring of the form '0...01...1' will have
        // an equal number of '0's and '1's.
        // The maximum length we can form from the current sequence of `count0` zeros
        // and `count1` ones is `2 * min(count0, count1)`.
        maxLen = Math.max(maxLen, Math.min(count0, count1) * 2);
    }

    return maxLen;
};