var minSwaps = function(s) {
    const n = s.length;
    let count0 = 0;
    let count1 = 0;

    for (let i = 0; i < n; i++) {
        if (s[i] === '0') {
            count0++;
        } else {
            count1++;
        }
    }

    // If the counts of '0's and '1's differ by more than 1, it's impossible to form an alternating string.
    if (Math.abs(count0 - count1) > 1) {
        return -1;
    }

    let swapsFor0101 = Infinity; // Target pattern: 010101...
    let swapsFor1010 = Infinity; // Target pattern: 101010...

    // Calculate swaps for target pattern starting with '0' (e.g., "0101...")
    // This pattern is possible if count0 >= count1 (e.g., 00011 or 0011)
    if (count0 >= count1) {
        let misplaced1s = 0; // '1's at positions where '0' should be (even indices)
        let misplaced0s = 0; // '0's at positions where '1' should be (odd indices)
        for (let i = 0; i < n; i++) {
            if (i % 2 === 0) { // Should be '0'
                if (s[i] === '1') {
                    misplaced1s++;
                }
            } else { // Should be '1'
                if (s[i] === '0') {
                    misplaced0s++;
                }
            }
        }
        // The number of swaps is half of the total mismatches.
        // misplaced1s should equal misplaced0s for a valid alternating string.
        swapsFor0101 = misplaced1s; 
    }

    // Calculate swaps for target pattern starting with '1' (e.g., "1010...")
    // This pattern is possible if count1 >= count0 (e.g., 11100 or 1100)
    if (count1 >= count0) {
        let misplaced0s = 0; // '0's at positions where '1' should be (even indices)
        let misplaced1s = 0; // '1's at positions where '0' should be (odd indices)
        for (let i = 0; i < n; i++) {
            if (i % 2 === 0) { // Should be '1'
                if (s[i] === '0') {
                    misplaced0s++;
                }
            } else { // Should be '0'
                if (s[i] === '1') {
                    misplaced1s++;
                }
            }
        }
        swapsFor1010 = misplaced0s;
    }

    // Return the minimum of the two possible swap counts.
    // If only one pattern was possible, the other will be Infinity.
    return Math.min(swapsFor0101, swapsFor1010);
};