var minFlipsMonoIncr = function(s) {
    let n = s.length;
    if (n === 0) {
        return 0;
    }

    // `zero_count` stores the minimum flips to make the prefix s[0...i] monotone increasing
    // and ending with '0' (meaning the entire prefix is '0's).
    // `one_count` stores the minimum flips to make the prefix s[0...i] monotone increasing
    // and ending with '1' (meaning the prefix is '0...01...1').

    // Initialize for the first character s[0]
    // If s[0] is '0':
    //   To make it '0', 0 flips.
    //   To make it '1', 1 flip.
    // If s[0] is '1':
    //   To make it '0', 1 flip.
    //   To make it '1', 0 flips.
    let zero_count = (s[0] === '1' ? 1 : 0);
    let one_count = (s[0] === '0' ? 1 : 0);

    // Iterate through the rest of the string
    for (let i = 1; i < n; i++) {
        let char = s[i];

        // Calculate `new_zero_count` for s[0...i] ending with '0'.
        // If the current character `char` is '1', we must flip it to '0'.
        // If `char` is '0', no flip needed.
        // The previous prefix s[0...i-1] must also have ended with '0'
        // (i.e., been all '0's) to maintain the all-'0' property.
        let new_zero_count = zero_count + (char === '1' ? 1 : 0);

        // Calculate `new_one_count` for s[0...i] ending with '1'.
        // If the current character `char` is '0', we must flip it to '1'.
        // If `char` is '1', no flip needed.
        // The previous prefix s[0...i-1] could have ended with '0' or '1'.
        // We take the minimum flips from either of those states.
        let new_one_count = Math.min(zero_count, one_count) + (char === '0' ? 1 : 0);

        // Update counts for the next iteration
        zero_count = new_zero_count;
        one_count = new_one_count;
    }

    // The result is the minimum of making the entire string end with '0' (all '0's)
    // or making it end with '1' ('0...01...1').
    return Math.min(zero_count, one_count);
};