function pyramidTransitionMatrix(bottom, allowed) {
    const map = new Map();
    for (const [a, b, c] of allowed) {
        if (!map.has(a + b)) {
            map.set(a + b, []);
        }
        map.get(a + b).push(c);
    }

    function dfs(current, nextLevel, index) {
        if (index === current.length - 1) {
            return nextLevel.length > 0;
        }

        const key = current[index] + current[index + 1];
        if (!map.has(key)) return false;

        const options = map.get(key);
        for (const option of options) {
            nextLevel.push(option);
            if (dfs(current, nextLevel, index + 1)) {
                return true;
            }
            nextLevel.pop();
        }
        return false;
    }

    return dfs(bottom, [], 0);
}