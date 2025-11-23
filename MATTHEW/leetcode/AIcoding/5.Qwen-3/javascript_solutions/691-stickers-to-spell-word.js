function minStickers(target, stickers) {
    const targetCount = new Array(26).fill(0);
    const stickerCounts = stickers.map(sticker => new Array(26).fill(0));

    for (let i = 0; i < target.length; i++) {
        targetCount[target.charCodeAt(i) - 97]++;
    }

    for (let i = 0; i < stickers.length; i++) {
        for (let j = 0; j < stickers[i].length; j++) {
            stickerCounts[i][stickers[i].charCodeAt(j) - 97]++;
        }
    }

    const memo = {};

    function dfs(state) {
        if (state in memo) return memo[state];

        let needed = 0;
        for (let i = 0; i < 26; i++) {
            if (targetCount[i] > 0 && state[i] < targetCount[i]) {
                needed++;
            }
        }
        if (needed === 0) return 0;

        let res = Infinity;
        for (let i = 0; i < stickers.length; i++) {
            const new_state = [...state];
            let hasUseful = false;
            for (let j = 0; j < 26; j++) {
                if (stickerCounts[i][j] > 0 && targetCount[j] > 0) {
                    hasUseful = true;
                    new_state[j] = Math.min(new_state[j] + stickerCounts[i][j], targetCount[j]);
                }
            }
            if (hasUseful) {
                const next = new_state.join(',');
                res = Math.min(res, 1 + dfs(next));
            }
        }

        memo[state.join(',')] = res;
        return res;
    }

    return dfs(new Array(26).fill(0));
}