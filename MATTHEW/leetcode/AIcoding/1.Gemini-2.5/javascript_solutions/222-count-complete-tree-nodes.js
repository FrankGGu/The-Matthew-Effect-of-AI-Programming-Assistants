var countNodes = function(root) {
    if (!root) {
        return 0;
    }

    function getLeftHeight(node) {
        let height = 0;
        while (node) {
            node = node.left;
            height++;
        }
        return height;
    }

    let leftHeight = getLeftHeight(root.left);
    let rightHeight = getLeftHeight(root.right);

    if (leftHeight === rightHeight) {
        return (1 << leftHeight) + countNodes(root.right);
    } else {
        return (1 << rightHeight) + countNodes(root.left);
    }
};