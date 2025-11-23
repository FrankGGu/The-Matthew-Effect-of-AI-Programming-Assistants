var minStickers = function(stickers, target) {
    const n = target.length;
    const memo = new Map();
    memo.set(0, 0);

    const count = (str) => {
        const freq = new Array(26).fill(0);
        for (const c of str) {
            freq[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
        return freq;
    };

    const targetCount = count(target);
    const stickerCounts = stickers.map(count);

    const dp = (mask) => {
        if (memo.has(mask)) return memo.get(mask);
        let res = Infinity;
        for (const sticker of stickerCounts) {
            let newMask = mask;
            const tempSticker = [...sticker];
            for (let i = 0; i < n; i++) {
                if ((mask & (1 << i)) === 0) {
                    const c = target[i];
                    if (tempSticker[c.charCodeAt(0) - 'a'.charCodeAt(0)] > 0) {
                        tempSticker[c.charCodeAt(0) - 'a'.charCodeAt(0)]--;
                        newMask |= (1 << i);
                    }
                }
            }
            if (newMask !== mask) {
                const next = dp(newMask);
                if (next !== -1) {
                    res = Math.min(res, 1 + next);
                }
            }
        }
        memo.set(mask, res === Infinity ? -1 : res);
        return memo.get(mask);
    };

    return dp(0);
};