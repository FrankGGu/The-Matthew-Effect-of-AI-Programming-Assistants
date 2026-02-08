var Codec = function() {

};

Codec.prototype.serialize = function(root) {
    const result = [];
    const dfs = (node) => {
        if (!node) {
            result.push("null");
            return;
        }
        result.push(node.val);
        dfs(node.left);
        dfs(node.right);
    };
    dfs(root);
    return result.join(",");
};

Codec.prototype.deserialize = function(data) {
    const nodes = data.split(",");
    let i = 0; 

    const dfs = () => {
        if (nodes[i] === "null") {
            i++;
            return null;
        }
        const node = new TreeNode(parseInt(nodes[i], 10));
        i++;
        node.left = dfs();
        node.right = dfs();
        return node;
    };

    return dfs();
};