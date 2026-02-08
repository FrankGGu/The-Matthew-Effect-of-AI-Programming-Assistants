var maximumCostSubstring = function(s, chars, vals) {
    // Create an array to store the cost of each lowercase English letter.
    // 'a' maps to index 0, 'b' to 1, ..., 'z' to 25.
    const charCosts = new Array(26);

    // Initialize default costs: 'a' -> 1, 'b' -> 2, ..., 'z' -> 26.
    for (let i = 0; i < 26; i++) {
        charCosts[i] = i + 1;
    }

    // Override default costs with custom values provided in 'chars' and 'vals'.
    for (let i = 0; i < chars.length; i++) {
        const charCode = chars.charCodeAt(i) - 'a'.charCodeAt(0);
        charCosts[charCode] = vals[i];
    }

    // Apply Kadane's algorithm to find the maximum sum subarray (substring cost).
    let maxSoFar = 0;    // Stores the maximum cost found so far (can be 0 for an empty substring).
    let currentMax = 0;  // Stores the maximum cost of the substring ending at the current position.

    for (let i = 0; i < s.length; i++) {
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        const cost = charCosts[charCode];

        // Add the current character's cost to the current running sum.
        currentMax += cost;

        // If currentMax becomes negative, it means this substring is no longer contributing
        // positively. We reset it to 0, effectively starting a new substring from the next character.
        // This handles cases where all previous characters lead to a negative sum, making it better
        // to start fresh or consider an empty substring (cost 0).
        if (currentMax < 0) {
            currentMax = 0;
        }

        // Update the overall maximum cost found.
        maxSoFar = Math.max(maxSoFar, currentMax);
    }

    return maxSoFar;
};