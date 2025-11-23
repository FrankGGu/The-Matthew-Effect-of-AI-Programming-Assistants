var serialize = function(root) {
    if (!root) return 'null';
    const left = serialize(root.left);
    const right = serialize(root.right);
    return root.val + ',' + left + ',' + right;
};

var deserialize = function(data) {
    const values = data.split(',');
    let i = 0;

    function buildTree() {
        if (values[i] === 'null') {
            i++;
            return null;
        }

        const node = new TreeNode(parseInt(values[i]));
        i++;
        node.left = buildTree();
        node.right = buildTree();
        return node;
    }

    return buildTree();
};