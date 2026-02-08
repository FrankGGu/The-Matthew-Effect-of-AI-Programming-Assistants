function evaluateBracketPairs(s) {
    const stack = [];
    const map = new Map();
    const result = [];

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (char === '(') {
            stack.push(i);
        } else if (char === ')') {
            const start = stack.pop();
            if (start !== undefined) {
                map.set(start, i);
            }
        }
    }

    function dfs(i) {
        if (i >= s.length) return '';
        if (map.has(i)) {
            const end = map.get(i);
            return dfs(i + 1) + dfs(end + 1);
        }
        return s[i] + dfs(i + 1);
    }

    return dfs(0);
}