var recoverFromPreorder = function(s) {
    if (!s) return null;

    let i = 0;
    const buildTree = (depth) => {
        let node = new TreeNode();
        while (i < s.length && s[i] !== '-') {
            node.val = node.val * 10 + parseInt(s[i]);
            i++;
        }

        if (i >= s.length) return node;

        let currentDepth = 0;
        while (i < s.length && s[i] === '-') {
            currentDepth++;
            i++;
        }

        if (currentDepth === depth) {
            node.left = buildTree(depth + 1);
            node.right = buildTree(depth + 1);
        }

        return node;
    };

    return buildTree(0);
};