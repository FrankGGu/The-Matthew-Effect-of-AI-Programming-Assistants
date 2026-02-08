class TreeNode {
    constructor(val = 0, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var serialize = function(root) {
    const result = [];
    const traverse = (node) => {
        if (!node) {
            result.push('null');
            return;
        }
        result.push(node.val);
        traverse(node.left);
        traverse(node.right);
    };
    traverse(root);
    return result.join(',');
};

var deserialize = function(data) {
    const nodes = data.split(',');
    let index = 0;

    const buildTree = () => {
        if (nodes[index] === 'null') {
            index++;
            return null;
        }
        const node = new TreeNode(parseInt(nodes[index++]));
        node.left = buildTree();
        node.right = buildTree();
        return node;
    };
    return buildTree();
};