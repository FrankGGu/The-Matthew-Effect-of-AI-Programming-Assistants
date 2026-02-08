class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var kthLargestPerfectSubtreeSize = function(root, k) {
    const sizes = [];

    const isPerfect = (node) => {
        if (!node) return [true, 0];
        const [leftPerfect, leftSize] = isPerfect(node.left);
        const [rightPerfect, rightSize] = isPerfect(node.right);
        const currentSize = leftSize + rightSize + 1;
        if (leftPerfect && rightPerfect && leftSize === rightSize) {
            sizes.push(currentSize);
            return [true, currentSize];
        }
        return [false, currentSize];
    };

    isPerfect(root);
    sizes.sort((a, b) => b - a);

    return sizes[k - 1] || -1;
};