var minStickers = function(stickers, target) {
    const n = target.length;
    const dp = new Array(1 << n).fill(Infinity);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        if (dp[mask] === Infinity) continue;

        for (const sticker of stickers) {
            let nextMask = mask;
            const counts = new Array(26).fill(0);
            for (const char of sticker) {
                counts[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
            }

            for (let i = 0; i < n; i++) {
                if (!(mask & (1 << i))) {
                    const charCode = target.charCodeAt(i) - 'a'.charCodeAt(0);
                    if (counts[charCode] > 0) {
                        counts[charCode]--;
                        nextMask |= (1 << i);
                    }
                }
            }

            dp[nextMask] = Math.min(dp[nextMask], dp[mask] + 1);
        }
    }

    return dp[(1 << n) - 1] === Infinity ? -1 : dp[(1 << n) - 1];
};