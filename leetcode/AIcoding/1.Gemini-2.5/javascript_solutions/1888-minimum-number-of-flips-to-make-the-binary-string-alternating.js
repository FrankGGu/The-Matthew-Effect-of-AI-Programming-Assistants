var minFlips = function(s) {
    const n = s.length;

    // If n is 0 or 1, the string is already alternating or trivially so.
    if (n <= 1) {
        return 0;
    }

    // Extend the string to handle rotations as contiguous substrings
    const s_extended = s + s;
    let min_flips_total = Infinity;

    // These variables will track flips for the current window of length n
    // flips0_pattern_start_0: counts flips needed if the current window should match "01010..."
    // flips1_pattern_start_1: counts flips needed if the current window should match "10101..."
    let flips0_pattern_start_0 = 0;
    let flips1_pattern_start_1 = 0;

    // Calculate initial flips for the first window s_extended[0...n-1] (which is the original string s)
    for (let k = 0; k < n; k++) {
        // For the "0101..." pattern, character at relative index k should be '0' if k is even, '1' if k is odd.
        if (s_extended[k] !== (k % 2).toString()) {
            flips0_pattern_start_0++;
        }
        // For the "1010..." pattern, character at relative index k should be '1' if k is even, '0' if k is odd.
        if (s_extended[k] !== ((k + 1) % 2).toString()) {
            flips1_pattern_start_1++;
        }
    }

    // Initialize min_flips_total with the results from the first window
    min_flips_total = Math.min(flips0_pattern_start_0, flips1_pattern_start_1);

    // Slide the window across s_extended
    // The loop runs 'n' times, considering 'n' different starting positions for the window.
    // 'i' represents the starting index of the current window in s_extended.
    // The window is s_extended[i ... i + n - 1].
    // We already processed i=0, so we start from i=1 up to n-1.
    for (let i = 1; i < n; i++) {
        // 1. Remove contribution of the character leaving the window: s_extended[i-1]
        // This character was at relative index 0 in the previous window.

        // Check if s_extended[i-1] was a mismatch for the "0101..." pattern at relative index 0
        if (s_extended[i - 1] !== (0 % 2).toString()) {
            flips0_pattern_start_0--;
        }
        // Check if s_extended[i-1] was a mismatch for the "1010..." pattern at relative index 0
        if (s_extended[i - 1] !== (1 % 2).toString()) {
            flips1_pattern_start_1--;
        }

        // 2. Add contribution of the character entering the window: s_extended[i + n - 1]
        // This character enters at relative index n-1 in the current window.

        // Check if s_extended[i + n - 1] is a mismatch for the "0101..." pattern at relative index n-1
        if (s_extended[i + n - 1] !== ((n - 1) % 2).toString()) {
            flips0_pattern_start_0++;
        }
        // Check if s_extended[i + n - 1] is a mismatch for the "1010..." pattern at relative index n-1
        if (s_extended[i + n - 1] !== (n % 2).toString()) { // (n % 2) is equivalent to ((n-1 + 1) % 2)
            flips1_pattern_start_1++;
        }

        // Update the minimum flips found so far
        min_flips_total = Math.min(min_flips_total, flips0_pattern_start_0, flips1_pattern_start_1);
    }

    return min_flips_total;
};