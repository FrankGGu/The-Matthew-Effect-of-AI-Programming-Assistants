var recoverFromPreorder = function(traversal) {
    let i = 0;

    function buildTree(depth) {
        let curDepth = 0;
        let temp = i;
        while (temp < traversal.length && traversal[temp] === '-') {
            curDepth++;
            temp++;
        }

        if (curDepth !== depth) {
            return null;
        }

        i = temp;
        let val = 0;
        while (i < traversal.length && traversal[i] !== '-') {
            val = val * 10 + parseInt(traversal[i]);
            i++;
        }

        let node = new TreeNode(val);
        node.left = buildTree(depth + 1);
        node.right = buildTree(depth + 1);

        return node;
    }

    return buildTree(0);
};