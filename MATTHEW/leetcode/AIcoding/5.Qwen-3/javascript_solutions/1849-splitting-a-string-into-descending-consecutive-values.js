function splitString(s) {
    const n = s.length;

    function dfs(start, prev) {
        if (start === n) return true;
        for (let i = start + 1; i <= n; i++) {
            const curr = parseInt(s.substring(start, i));
            if (prev === null || curr === prev - 1) {
                if (dfs(i, curr)) return true;
            }
        }
        return false;
    }

    for (let i = 1; i < n; i++) {
        const first = parseInt(s.substring(0, i));
        if (dfs(i, first)) return true;
    }
    return false;
}