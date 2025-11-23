var postorder = function(root) {
    const result = [];

    function traverse(node) {
        if (!node) {
            return;
        }

        if (node.children) {
            for (const child of node.children) {
                traverse(child);
            }
        }

        result.push(node.val);
    }

    traverse(root);
    return result;
};