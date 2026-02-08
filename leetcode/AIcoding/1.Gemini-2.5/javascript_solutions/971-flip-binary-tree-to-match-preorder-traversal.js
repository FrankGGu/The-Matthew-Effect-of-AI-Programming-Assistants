var flipMatchVoyage = function(root, voyage) {
    let idx = 0;
    const ans = [];
    let possible = true;

    function dfs(node) {
        if (!node || !possible) {
            return;
        }

        if (node.val !== voyage[idx]) {
            possible = false;
            return;
        }

        idx++;

        if (node.left && idx < voyage.length && node.left.val !== voyage[idx]) {
            ans.push(node.val);
            dfs(node.right);
            dfs(node.left);
        } else {
            dfs(node.left);
            dfs(node.right);
        }
    }

    dfs(root);

    if (!possible) {
        return [-1];
    }
    return ans;
};