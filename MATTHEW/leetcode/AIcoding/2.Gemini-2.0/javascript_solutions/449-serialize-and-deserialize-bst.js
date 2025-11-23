var serialize = function(root) {
    const arr = [];
    function traverse(node) {
        if (!node) {
            arr.push('null');
            return;
        }
        arr.push(node.val.toString());
        traverse(node.left);
        traverse(node.right);
    }
    traverse(root);
    return arr.join(',');
};

var deserialize = function(data) {
    const arr = data.split(',');
    let i = 0;

    function buildTree() {
        if (arr[i] === 'null') {
            i++;
            return null;
        }
        const node = new TreeNode(parseInt(arr[i]));
        i++;
        node.left = buildTree();
        node.right = buildTree();
        return node;
    }

    return buildTree();
};