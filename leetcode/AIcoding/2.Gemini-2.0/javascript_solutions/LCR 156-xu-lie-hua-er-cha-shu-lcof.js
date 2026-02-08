var serialize = function(root) {
    if (!root) return "null,";
    let left = serialize(root.left);
    let right = serialize(root.right);
    return root.val + "," + left + right;
};

var deserialize = function(data) {
    let list = data.split(",");
    let index = 0;

    function buildTree() {
        if (list[index] === "null") {
            index++;
            return null;
        }

        let root = new TreeNode(parseInt(list[index]));
        index++;
        root.left = buildTree();
        root.right = buildTree();
        return root;
    }

    return buildTree();
};