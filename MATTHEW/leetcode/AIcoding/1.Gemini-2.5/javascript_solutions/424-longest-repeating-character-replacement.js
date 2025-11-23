var characterReplacement = function(s, k) {
    let left = 0;
    let maxLen = 0;
    let maxFreq = 0; // Max frequency of any character in the current window
    const counts = new Array(26).fill(0); // Frequency map for 'A' through 'Z'

    for (let right = 0; right < s.length; right++) {
        const charCode = s.charCodeAt(right) - 'A'.charCodeAt(0);
        counts[charCode]++;
        maxFreq = Math.max(maxFreq, counts[charCode]);

        // Check if the current window is invalid
        // (current window length - max frequency of any char in window) > k
        // This means we need more than k replacements to make it a repeating character substring
        if ((right - left + 1) - maxFreq > k) {
            // Shrink the window from the left
            const leftCharCode = s.charCodeAt(left) - 'A'.charCodeAt(0);
            counts[leftCharCode]--;
            left++;
            // Note: maxFreq is NOT explicitly updated downwards here.
            // This is a common optimization for this problem.
            // maxFreq only ever stores the maximum frequency encountered so far in any valid window.
            // The logic relies on the fact that if we have a window of length L
            // with maxFreq M, and L-M <= k, then this is a valid candidate.
            // If we then shrink the window, maxFreq might decrease, but we don't need to track it perfectly
            // for the new smaller window. If a longer window is found later, its maxFreq will be correctly captured.
            // The condition (right - left + 1) - maxFreq > k will eventually force 'left' to move
            // enough to make the window valid, or prevent it from growing too large.
        }

        // Update maxLen with the length of the current valid window
        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
};