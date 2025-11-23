function longestPath(parent, s) {
    const n = s.length;
    const tree = Array.from({ length: n }, () => []);

    for (let i = 1; i < n; i++) {
        tree[parent[i]].push(i);
    }

    let maxLen = 0;

    function dfs(node) {
        let first = 0, second = 0;

        for (const child of tree[node]) {
            const len = dfs(child);
            if (s[child] !== s[node]) {
                if (len > first) {
                    second = first;
                    first = len;
                } else if (len > second) {
                    second = len;
                }
            }
        }

        maxLen = Math.max(maxLen, first + second + 1);
        return first + 1;
    }

    dfs(0);
    return maxLen;
}