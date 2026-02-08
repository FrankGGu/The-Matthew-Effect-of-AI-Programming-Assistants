var balancedString = function(s) {
    const n = s.length;
    const k = n / 4;

    // Count initial frequencies of each character in the entire string
    const counts = { 'Q': 0, 'W': 0, 'E': 0, 'R': 0 };
    for (let i = 0; i < n; i++) {
        counts[s[i]]++;
    }

    // Helper function to check if the characters outside the current window are balanced
    // This means no character count outside the window exceeds k.
    const isBalancedOutside = () => {
        return counts['Q'] <= k && counts['W'] <= k && counts['E'] <= k && counts['R'] <= k;
    };

    // If the string is already balanced, no replacement is needed.
    if (isBalancedOutside()) {
        return 0;
    }

    let minLen = n;
    let left = 0;

    // Iterate with the right pointer to expand the window
    for (let right = 0; right < n; right++) {
        // When s[right] is included in the window, it's effectively "removed" from the outside part.
        // So, decrement its count in our 'counts' map, which tracks outside characters.
        counts[s[right]]--;

        // While the characters outside the current window [left...right] are balanced,
        // we have a candidate substring. Try to shrink it from the left.
        while (isBalancedOutside()) {
            // Update the minimum length found so far
            minLen = Math.min(minLen, right - left + 1);

            // When s[left] is moved out of the window (i.e., window shrinks),
            // it's effectively "added back" to the outside part.
            // So, increment its count in our 'counts' map.
            counts[s[left]]++;
            left++;
        }
    }

    return minLen;
};