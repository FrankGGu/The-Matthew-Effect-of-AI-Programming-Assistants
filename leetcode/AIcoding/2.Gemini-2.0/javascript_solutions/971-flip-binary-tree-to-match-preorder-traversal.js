var flipMatchVoyage = function(root, voyage) {
    const flipped = [];
    let index = 0;

    function dfs(node) {
        if (!node) {
            return true;
        }

        if (node.val !== voyage[index]) {
            return false;
        }

        index++;

        if (node.left && node.left.val !== voyage[index] && node.right && node.right.val === voyage[index]) {
            flipped.push(node.val);
            let temp = node.left;
            node.left = node.right;
            node.right = temp;
        }

        return dfs(node.left) && dfs(node.right);
    }

    if (dfs(root)) {
        return flipped;
    } else {
        return [-1];
    }
};