var serialize = function(root) {
    if (!root) return 'null';
    const queue = [root];
    const result = [];
    while (queue.length) {
        const node = queue.shift();
        if (node) {
            result.push(node.val);
            queue.push(node.left);
            queue.push(node.right);
        } else {
            result.push('null');
        }
    }
    return result.join(',');
};

var deserialize = function(data) {
    if (data === 'null') return null;
    const nodes = data.split(',');
    const root = new TreeNode(parseInt(nodes[0]));
    const queue = [root];
    let i = 1;
    while (queue.length && i < nodes.length) {
        const node = queue.shift();
        const leftVal = nodes[i++];
        if (leftVal !== 'null') {
            node.left = new TreeNode(parseInt(leftVal));
            queue.push(node.left);
        }
        const rightVal = nodes[i++];
        if (rightVal !== 'null') {
            node.right = new TreeNode(parseInt(rightVal));
            queue.push(node.right);
        }
    }
    return root;
};