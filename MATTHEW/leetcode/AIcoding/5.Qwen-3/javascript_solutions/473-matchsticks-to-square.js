function matchsticksToSquare(matchsticks) {
    const total = matchsticks.reduce((sum, val) => sum + val, 0);
    if (total % 4 !== 0) return false;
    const target = total / 4;
    matchsticks.sort((a, b) => b - a);

    const dfs = (index, current, used, k) => {
        if (k === 4) return true;
        if (current === target) return dfs(0, 0, used, k + 1);
        for (let i = index; i < matchsticks.length; i++) {
            if (!used[i] && current + matchsticks[i] <= target) {
                used[i] = true;
                if (dfs(i + 1, current + matchsticks[i], used, k)) return true;
                used[i] = false;
            }
        }
        return false;
    };

    return dfs(0, 0, new Array(matchsticks.length).fill(false), 0);
}