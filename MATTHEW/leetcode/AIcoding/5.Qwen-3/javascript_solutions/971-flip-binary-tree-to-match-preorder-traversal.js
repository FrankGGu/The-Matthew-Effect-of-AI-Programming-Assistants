function flipMatchVoyage(root, voyage) {
    let res = [];
    let i = 0;

    function dfs(node) {
        if (!node) return;
        if (node.val !== voyage[i++]) {
            res = [-1];
            return;
        }
        if (node.left && node.left.val !== voyage[i]) {
            [node.left, node.right] = [node.right, node.left];
            res.push(node.val);
        }
        dfs(node.left);
        dfs(node.right);
    }

    dfs(root);
    return res[0] === -1 ? [-1] : res;
}