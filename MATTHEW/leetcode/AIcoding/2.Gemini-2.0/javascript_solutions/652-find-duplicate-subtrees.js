var findDuplicateSubtrees = function(root) {
    const seen = new Map();
    const ans = [];

    function traverse(node) {
        if (!node) return '#';
        const subtree = node.val + ',' + traverse(node.left) + ',' + traverse(node.right);

        if (seen.has(subtree)) {
            if (seen.get(subtree) === 1) {
                ans.push(node);
            }
            seen.set(subtree, seen.get(subtree) + 1);
        } else {
            seen.set(subtree, 1);
        }
        return subtree;
    }

    traverse(root);
    return ans;
};