var longestSpecialPath = function(parent, s) {
    const n = parent.length;
    const children = Array.from({ length: n }, () => []);
    for (let i = 1; i < n; i++) {
        children[parent[i]].push(i);
    }

    let maxLen = 1;

    const dfs = (node) => {
        let max1 = 0, max2 = 0;
        for (const child of children[node]) {
            const childLen = dfs(child);
            if (s[child] !== s[node]) {
                if (childLen > max1) {
                    max2 = max1;
                    max1 = childLen;
                } else if (childLen > max2) {
                    max2 = childLen;
                }
            }
        }
        maxLen = Math.max(maxLen, max1 + max2 + 1);
        return max1 + 1;
    };

    dfs(0);
    return maxLen;
};