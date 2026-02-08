var kthLargestPerfectSubtreeSize = function(root, k) {
    const sizes = [];

    function isPerfect(node, height, level = 0) {
        if (!node) {
            return true;
        }

        if (!node.left && !node.right) {
            return height === level + 1;
        }

        if (!node.left || !node.right) {
            return false;
        }

        return isPerfect(node.left, height, level + 1) && isPerfect(node.right, height, level + 1);
    }

    function getHeight(node) {
        if (!node) {
            return 0;
        }
        return 1 + Math.max(getHeight(node.left), getHeight(node.right));
    }

    function getSize(node) {
        if (!node) {
            return 0;
        }
        return 1 + getSize(node.left) + getSize(node.right);
    }

    function traverse(node) {
        if (!node) {
            return;
        }

        const height = getHeight(node);
        if (isPerfect(node, height)) {
            sizes.push(getSize(node));
        }

        traverse(node.left);
        traverse(node.right);
    }

    traverse(root);

    sizes.sort((a, b) => b - a);

    if (k > sizes.length) {
        return -1;
    }

    return sizes[k - 1] === undefined ? -1 : sizes[k - 1];
};