var printTree = function(root) {
    if (!root) return [[]];

    const height = (node) => {
        if (!node) return 0;
        return 1 + Math.max(height(node.left), height(node.right));
    };

    const h = height(root);
    const width = (1 << h) - 1;
    const res = Array.from({ length: h }, () => Array(width).fill(''));

    const fill = (node, level, pos) => {
        if (!node) return;
        res[level][pos] = node.val;
        fill(node.left, level + 1, pos - (1 << (h - level - 1)));
        fill(node.right, level + 1, pos + (1 << (h - level - 1)));
    };

    fill(root, 0, (width - 1) / 2);
    return res;
};