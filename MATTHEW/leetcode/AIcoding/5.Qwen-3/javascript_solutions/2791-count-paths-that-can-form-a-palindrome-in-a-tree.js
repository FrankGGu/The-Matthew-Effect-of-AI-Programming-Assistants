function countPalindromePaths(root) {
    const count = new Map();
    count.set(0, 1);
    let result = 0;

    function dfs(node, path) {
        if (!node) return;
        path ^= (1 << (node.val - 1));
        if (count.has(path)) {
            result += count.get(path);
        }
        for (let i = 0; i < 26; i++) {
            const mask = path ^ (1 << i);
            if (count.has(mask)) {
                result += count.get(mask);
            }
        }
        count.set(path, (count.get(path) || 0) + 1);
        dfs(node.left, path);
        dfs(node.right, path);
    }

    dfs(root, 0);
    return result;
}