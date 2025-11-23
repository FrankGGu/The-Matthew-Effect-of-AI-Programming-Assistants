var findDuplicateSubtrees = function(root) {
    const counts = new Map();
    const result = [];

    function dfs(node) {
        if (!node) {
            return "#";
        }

        const left_serialize = dfs(node.left);
        const right_serialize = dfs(node.right);

        const subtree_serialize = node.val + "," + left_serialize + "," + right_serialize;

        counts.set(subtree_serialize, (counts.get(subtree_serialize) || 0) + 1);

        if (counts.get(subtree_serialize) === 2) {
            result.push(node);
        }

        return subtree_serialize;
    }

    dfs(root);
    return result;
};