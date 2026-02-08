class TreeNode {
    constructor(val = 0, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var serialize = function(root) {
    const result = [];
    const dfs = (node) => {
        if (!node) {
            result.push('#');
            return;
        }
        result.push(node.val);
        dfs(node.left);
        dfs(node.right);
    };
    dfs(root);
    return result.join(',');
};

var deserialize = function(data) {
    const nodes = data.split(',');
    let index = 0;

    const dfs = () => {
        if (nodes[index] === '#') {
            index++;
            return null;
        }
        const node = new TreeNode(parseInt(nodes[index++]));
        node.left = dfs();
        node.right = dfs();
        return node;
    };

    return dfs();
};