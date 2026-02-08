var minStickers = function(stickers, target) {
    const N = target.length;
    const finalMask = (1 << N) - 1;

    // Convert target characters to their ASCII values relative to 'a'
    const targetCharCodes = new Array(N);
    for (let i = 0; i < N; i++) {
        targetCharCodes[i] = target.charCodeAt(i) - 'a'.charCodeAt(0);
    }

    // Pre-process stickers: convert each sticker to a frequency map of its characters
    // Only count characters that are present in the target word.
    const stickerCounts = [];
    for (const sticker of stickers) {
        const counts = new Array(26).fill(0);
        for (const char of sticker) {
            counts[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
        stickerCounts.push(counts);
    }

    // dp[mask] will store the minimum number of stickers needed to form the characters
    // represented by the set bits in 'mask'.
    // Initialize dp array with Infinity, dp[0] = 0 (0 stickers for an empty string).
    const dp = new Array(1 << N).fill(Infinity);
    dp[0] = 0;

    // Iterate through all possible masks from 0 up to (1 << N) - 2
    // We want to find dp[finalMask]
    for (let mask = 0; mask < finalMask; mask++) {
        if (dp[mask] === Infinity) {
            // If this state is unreachable, skip it
            continue;
        }

        // Try applying each sticker to the current mask
        for (const sCounts of stickerCounts) {
            // Make a copy of sticker counts for this iteration
            const tempStickerCounts = [...sCounts];
            let newMask = mask;

            // Try to cover uncovered characters in target using the current sticker
            for (let i = 0; i < N; i++) {
                // If the i-th character of target is not yet covered in 'mask'
                // and the current sticker has this character
                if (!((newMask >> i) & 1) && tempStickerCounts[targetCharCodes[i]] > 0) {
                    // Cover this character
                    newMask |= (1 << i);
                    // Use one instance of this character from the sticker
                    tempStickerCounts[targetCharCodes[i]]--;
                }
            }

            // If the sticker actually covered new characters (i.e., newMask is different from mask)
            if (newMask !== mask) {
                // Update dp[newMask] with the minimum stickers count
                dp[newMask] = Math.min(dp[newMask], dp[mask] + 1);
            }
        }
    }

    // The result is dp[finalMask]. If it's still Infinity, it's impossible to form the target.
    return dp[finalMask] === Infinity ? -1 : dp[finalMask];
};