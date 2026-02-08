var findSubstringInWraproundString = function(p) {
    if (p.length === 0) {
        return 0;
    }

    // dp[i] stores the maximum length of a valid wraparound substring ending with the i-th character of the alphabet.
    // 'a' corresponds to index 0, 'b' to 1, ..., 'z' to 25.
    const dp = new Array(26).fill(0);

    let currentMaxLen = 0;

    for (let i = 0; i < p.length; i++) {
        const charCode = p.charCodeAt(i);
        const charIndex = charCode - 'a'.charCodeAt(0);

        if (i > 0) {
            const prevCharCode = p.charCodeAt(i - 1);
            // Check if current character follows the previous character in wraparound order
            // (e.g., 'b' after 'a', 'a' after 'z')
            // (charCode - prevCharCode + 26) % 26 will be 1 if it's a consecutive character
            if ((charCode - prevCharCode + 26) % 26 === 1) {
                currentMaxLen++;
            } else {
                currentMaxLen = 1; // Sequence broken, start a new one of length 1
            }
        } else {
            currentMaxLen = 1; // First character always starts a sequence of length 1
        }

        // Update the maximum length for the substring ending with the current character
        dp[charIndex] = Math.max(dp[charIndex], currentMaxLen);
    }

    // The total number of unique substrings is the sum of all maximum lengths
    // because for each character, if its max length is L, it contributes L unique substrings ending with it.
    let totalUniqueSubstrings = 0;
    for (let i = 0; i < 26; i++) {
        totalUniqueSubstrings += dp[i];
    }

    return totalUniqueSubstrings;
};