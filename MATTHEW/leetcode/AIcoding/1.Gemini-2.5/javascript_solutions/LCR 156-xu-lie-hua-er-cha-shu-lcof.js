var serialize = function(root) {
    const result = [];

    function dfs(node) {
        if (!node) {
            result.push("null");
            return;
        }
        result.push(node.val);
        dfs(node.left);
        dfs(node.right);
    }

    dfs(root);
    return result.join(",");
};

var deserialize = function(data) {
    const nodes = data.split(",");
    let index = 0;

    function buildTree() {
        if (nodes[index] === "null") {
            index++;
            return null;
        }

        const node = new TreeNode(parseInt(nodes[index]));
        index++;
        node.left = buildTree();
        node.right = buildTree();
        return node;
    }

    return buildTree();
};