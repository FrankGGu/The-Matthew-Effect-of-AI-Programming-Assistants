var decorateTree = function(root, flowers) {
    let index = 0;

    function dfs(node) {
        if (!node) {
            return true;
        }

        if (!dfs(node.left)) {
            return false;
        }

        if (node.val === -1) {
            if (index < flowers.length) {
                node.val = flowers[index];
                index++;
            } else {
                return false;
            }
        }

        if (!dfs(node.right)) {
            return false;
        }

        return true;
    }

    if (dfs(root) && index === flowers.length) {
        return true;
    } else {
        return false;
    }
};