var maxProduct = function(s) {
    const n = s.length;
    let maxProd = 0;
    const palindromeLengths = new Map(); // Stores mask -> length of palindrome for that mask

    // Helper to check if a subsequence defined by a mask is a palindrome.
    // Returns its length if it's a palindrome, 0 otherwise.
    const getPalindromeLength = (mask) => {
        let chars = [];
        for (let i = 0; i < n; i++) {
            if ((mask >> i) & 1) {
                chars.push(s[i]);
            }
        }
        if (chars.length === 0) return 0;

        let left = 0;
        let right = chars.length - 1;
        while (left < right) {
            if (chars[left] !== chars[right]) {
                return 0; // Not a palindrome
            }
            left++;
            right--;
        }
        return chars.length; // Is a palindrome, return its length
    };

    // Pre-calculate palindrome lengths for all possible non-empty masks.
    // Iterate from 1 to (1 << n) - 1 to exclude the empty mask (0).
    for (let i = 1; i < (1 << n); i++) {
        const len = getPalindromeLength(i);
        if (len > 0) {
            palindromeLengths.set(i, len);
        }
    }

    // Iterate through all pairs of masks that represent palindromic subsequences
    // and check if they are disjoint.
    const masks = Array.from(palindromeLengths.keys());
    const numPalindromes = masks.length;

    for (let i = 0; i < numPalindromes; i++) {
        const mask1 = masks[i];
        const len1 = palindromeLengths.get(mask1);

        // Start j from i + 1 to avoid duplicate pairs (mask1, mask2) and (mask2, mask1)
        // and to avoid comparing a mask with itself.
        for (let j = i + 1; j < numPalindromes; j++) {
            const mask2 = masks[j];
            const len2 = palindromeLengths.get(mask2);

            // Check if masks are disjoint (i.e., they do not share any common set bits,
            // meaning no character from the original string is used in both subsequences).
            if ((mask1 & mask2) === 0) {
                maxProd = Math.max(maxProd, len1 * len2);
            }
        }
    }

    return maxProd;
};