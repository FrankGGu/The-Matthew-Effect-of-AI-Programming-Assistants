var serialize = function(root) {
    const result = [];

    function preOrder(node) {
        if (!node) {
            result.push('#');
            return;
        }
        result.push(node.val);
        preOrder(node.left);
        preOrder(node.right);
    }

    preOrder(root);
    return result.join(',');
};

var deserialize = function(data) {
    const nodes = data.split(',');
    let index = 0;

    function buildTree() {
        if (index >= nodes.length) {
            return null;
        }

        const val = nodes[index];
        index++;

        if (val === '#') {
            return null;
        }

        const node = new TreeNode(parseInt(val));
        node.left = buildTree();
        node.right = buildTree();
        return node;
    }

    return buildTree();
};