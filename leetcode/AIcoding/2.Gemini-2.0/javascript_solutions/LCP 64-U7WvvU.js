var lightUp = function(root) {
    let ans = 0;

    function dfs(node) {
        if (!node) return 0;

        let left = dfs(node.left);
        let right = dfs(node.right);

        if (left === -1 || right === -1) {
            ans++;
            return 1;
        } else if (left === 1 || right === 1) {
            return 0;
        } else {
            return -1;
        }
    }

    if (dfs(root) === -1) {
        ans++;
    }

    return ans;
};