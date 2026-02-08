var longestAwesome = function(s) {
    let n = s.length;
    let ans = 0;
    let currentMask = 0;
    // pos[mask] stores the first index `i-1` where the prefix mask `mask` was encountered.
    // We use an array for faster lookups since mask values are small (0 to 1023).
    // Initialize with -2 to indicate not seen, as -1 is used for the initial mask 0.
    let pos = new Array(1 << 10).fill(-2); 

    // The state before the string starts: mask 0 encountered at index -1.
    // This handles cases where the awesome substring starts from index 0.
    pos[0] = -1; 

    for (let j = 0; j < n; j++) {
        let digit = parseInt(s[j]);
        // Toggle the bit corresponding to the current digit.
        // This updates the parity mask for the prefix s[0...j].
        currentMask ^= (1 << digit); 

        // Case 1: The substring s[pos[currentMask]+1 ... j] has all digits appearing an even number of times.
        // This means (currentMask XOR pos[currentMask]'s mask) == 0.
        if (pos[currentMask] !== -2) {
            ans = Math.max(ans, j - pos[currentMask]);
        } else {
            // If this is the first time we see currentMask, store its index.
            // We only store the first occurrence to maximize the length of the substring.
            pos[currentMask] = j;
        }

        // Case 2: The substring s[pos[targetMask]+1 ... j] has exactly one digit appearing an odd number of times.
        // This means (currentMask XOR pos[targetMask]'s mask) == (1 << k) for some k.
        // So, pos[targetMask]'s mask must be currentMask XOR (1 << k).
        for (let k = 0; k < 10; k++) {
            let targetMask = currentMask ^ (1 << k);
            if (pos[targetMask] !== -2) {
                ans = Math.max(ans, j - pos[targetMask]);
            }
        }
    }

    return ans;
};