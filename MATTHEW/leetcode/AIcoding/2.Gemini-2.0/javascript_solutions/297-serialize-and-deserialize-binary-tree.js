var serialize = function(root) {
    if (!root) return "null";
    let left = serialize(root.left);
    let right = serialize(root.right);
    return root.val + "," + left + "," + right;
};

var deserialize = function(data) {
    let values = data.split(",");
    let i = 0;

    function buildTree() {
        if (values[i] === "null") {
            i++;
            return null;
        }
        let root = new TreeNode(parseInt(values[i]));
        i++;
        root.left = buildTree();
        root.right = buildTree();
        return root;
    }

    return buildTree();
};