var minStickers = function(stickers, target) {
    const dp = {};

    const dfs = (t) => {
        if (t === '') return 0;
        if (dp[t] !== undefined) return dp[t];

        let res = Infinity;
        for (const sticker of stickers) {
            let nextT = t;
            const count = Array(26).fill(0);
            for (const char of sticker) {
                count[char.charCodeAt() - 97]++;
            }

            let j = 0;
            while (j < nextT.length) {
                const charIndex = nextT[j].charCodeAt() - 97;
                if (count[charIndex] > 0) {
                    count[charIndex]--;
                    nextT = nextT.slice(0, j) + nextT.slice(j + 1);
                } else {
                    j++;
                }
            }

            const subRes = dfs(nextT);
            if (subRes !== Infinity) {
                res = Math.min(res, subRes + 1);
            }
        }

        dp[t] = res;
        return res;
    };

    const result = dfs(target);
    return result === Infinity ? -1 : result;
};