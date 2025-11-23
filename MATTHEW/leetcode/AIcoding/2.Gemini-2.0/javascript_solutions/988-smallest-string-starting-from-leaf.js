var smallestFromLeaf = function(root) {
    let ans = '~';

    function dfs(node, str) {
        if (!node) {
            return;
        }

        str = String.fromCharCode(node.val + 97) + str;

        if (!node.left && !node.right) {
            if (str < ans) {
                ans = str;
            }
            return;
        }

        dfs(node.left, str);
        dfs(node.right, str);
    }

    dfs(root, "");
    return ans;
};