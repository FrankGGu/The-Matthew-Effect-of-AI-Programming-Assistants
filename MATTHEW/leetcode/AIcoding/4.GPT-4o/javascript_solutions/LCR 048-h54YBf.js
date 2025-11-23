class TreeNode {
    constructor(val = 0, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var serialize = function(root) {
    const result = [];
    const helper = (node) => {
        if (!node) {
            result.push('null');
            return;
        }
        result.push(node.val);
        helper(node.left);
        helper(node.right);
    };
    helper(root);
    return result.join(',');
};

var deserialize = function(data) {
    const list = data.split(',');
    let index = 0;

    const helper = () => {
        if (list[index] === 'null') {
            index++;
            return null;
        }
        const node = new TreeNode(parseInt(list[index]));
        index++;
        node.left = helper();
        node.right = helper();
        return node;
    };

    return helper();
};