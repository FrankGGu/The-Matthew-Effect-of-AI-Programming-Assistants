function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}

var Codec = function() {

};

Codec.prototype.serialize = function(root) {
    const nodes = [];

    function dfs(node) {
        if (!node) {
            nodes.push('#');
            return;
        }
        nodes.push(node.val);
        dfs(node.left);
        dfs(node.right);
    }

    dfs(root);
    return nodes.join(',');
};

Codec.prototype.deserialize = function(data) {
    const dataArray = data.split(',');
    let i = 0;

    function buildTree() {
        const val = dataArray[i];
        i++;

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