var countPalindromicPaths = function(root) {
    let count = 0;

    const dfs = (node, path) => {
        if (!node) return;
        path[node.val] = (path[node.val] || 0) + 1;

        if (!node.left && !node.right) {
            if (isPalindrome(path)) count++;
        }

        dfs(node.left, path);
        dfs(node.right, path);

        path[node.val]--;
    };

    const isPalindrome = (path) => {
        let oddCount = 0;
        for (const key in path) {
            if (path[key] % 2 === 1) oddCount++;
        }
        return oddCount <= 1;
    };

    dfs(root, {});
    return count;
};