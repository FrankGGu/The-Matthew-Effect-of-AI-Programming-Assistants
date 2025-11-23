var pyramidTransition = function(bottom, allowed) {
    const map = new Map();
    for (const s of allowed) {
        const key = s.substring(0, 2);
        if (!map.has(key)) {
            map.set(key, []);
        }
        map.get(key).push(s[2]);
    }

    function dfs(current, next, idx) {
        if (current.length === 1) {
            return true;
        }
        if (idx === current.length - 1) {
            return dfs(next, "", 0);
        }
        const key = current.substring(idx, idx + 2);
        if (!map.has(key)) {
            return false;
        }
        for (const ch of map.get(key)) {
            if (dfs(current, next + ch, idx + 1)) {
                return true;
            }
        }
        return false;
    }

    return dfs(bottom, "", 0);
};