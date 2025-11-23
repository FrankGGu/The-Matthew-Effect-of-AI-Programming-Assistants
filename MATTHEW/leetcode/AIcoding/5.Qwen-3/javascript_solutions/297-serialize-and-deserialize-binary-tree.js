var serialize = function(root) {
    if (!root) return "";

    const result = [];
    const queue = [root];

    while (queue.length) {
        const node = queue.shift();
        if (node) {
            result.push(node.val);
            queue.push(node.left);
            queue.push(node.right);
        } else {
            result.push("null");
        }
    }

    return result.join(",");
};

var deserialize = function(data) {
    if (!data) return null;

    const values = data.split(",");
    const root = new TreeNode(parseInt(values[0]));
    const queue = [root];
    let i = 1;

    while (queue.length && i < values.length) {
        const node = queue.shift();
        if (values[i] !== "null") {
            node.left = new TreeNode(parseInt(values[i]));
            queue.push(node.left);
        }
        i++;
        if (values[i] !== "null") {
            node.right = new TreeNode(parseInt(values[i]));
            queue.push(node.right);
        }
        i++;
    }

    return root;
};

function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}