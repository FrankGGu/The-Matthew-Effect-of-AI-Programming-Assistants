var wonderfulSubstrings = function(word) {
    let count = 0;
    let prefixMask = 0;
    const freq = new Array(1 << 10).fill(0);
    freq[0] = 1; // Represents the empty prefix

    for (let i = 0; i < word.length; i++) {
        const charIndex = word.charCodeAt(i) - 'a'.charCodeAt(0);
        prefixMask ^= (1 << charIndex);

        // Case 1: All characters appear an even number of times
        // This means prefixMask ^ previous_prefixMask = 0
        // So, previous_prefixMask must be equal to prefixMask
        count += freq[prefixMask];

        // Case 2: Exactly one character appears an odd number of times
        // This means prefixMask ^ previous_prefixMask has exactly one bit set
        // Iterate through all possible single-bit masks (0 to 9)
        for (let j = 0; j < 10; j++) {
            const targetMask = prefixMask ^ (1 << j);
            count += freq[targetMask];
        }

        freq[prefixMask]++;
    }

    return count;
};