var preorder = function(root) {
    const result = [];

    function traverse(node) {
        if (!node) {
            return;
        }

        result.push(node.val);

        if (node.children) {
            for (let i = 0; i < node.children.length; i++) {
                traverse(node.children[i]);
            }
        }
    }

    traverse(root);
    return result;
};