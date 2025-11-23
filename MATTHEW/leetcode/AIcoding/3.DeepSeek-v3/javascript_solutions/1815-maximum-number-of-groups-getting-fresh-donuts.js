const maxHappyGroups = function(batchSize, groups) {
    const memo = new Map();
    let res = 0;
    let state = Array(batchSize).fill(0);
    for (let g of groups) {
        const mod = g % batchSize;
        if (mod === 0) res++;
        else state[mod]++;
    }

    function dfs(state, left) {
        const key = state.join(',') + `|${left}`;
        if (memo.has(key)) return memo.get(key);
        let max = 0;
        for (let i = 1; i < batchSize; i++) {
            if (state[i] === 0) continue;
            const newState = state.slice();
            newState[i]--;
            const newLeft = (left - i + batchSize) % batchSize;
            const current = (newLeft === 0) ? 1 : 0;
            max = Math.max(max, current + dfs(newState, newLeft));
        }
        memo.set(key, max);
        return max;
    }

    res += dfs(state, 0);
    return res;
};