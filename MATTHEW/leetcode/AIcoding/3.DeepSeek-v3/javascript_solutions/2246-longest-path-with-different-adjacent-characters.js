var longestPath = function(parent, s) {
    const n = parent.length;
    const children = Array.from({ length: n }, () => []);
    for (let i = 1; i < n; i++) {
        children[parent[i]].push(i);
    }
    let max = 1;

    const dfs = (node) => {
        let longest = 0;
        let secondLongest = 0;
        for (const child of children[node]) {
            const length = dfs(child);
            if (s[child] !== s[node]) {
                if (length > longest) {
                    secondLongest = longest;
                    longest = length;
                } else if (length > secondLongest) {
                    secondLongest = length;
                }
            }
        }
        max = Math.max(max, longest + secondLongest + 1);
        return longest + 1;
    };

    dfs(0);
    return max;
};