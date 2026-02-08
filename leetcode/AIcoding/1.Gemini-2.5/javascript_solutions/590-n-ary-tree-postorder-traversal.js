var postorder = function(root) {
    const result = [];

    function traverse(node) {
        if (!node) {
            return;
        }

        if (node.children) {
            for (let i = 0; i < node.children.length; i++) {
                traverse(node.children[i]);
            }
        }

        result.push(node.val);
    }

    traverse(root);
    return result;
};