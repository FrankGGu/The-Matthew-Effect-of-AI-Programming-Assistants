class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var maximizeTheTargetNodes = function(root1, root2) {
    const countNodes = (root) => {
        if (!root) return 0;
        return 1 + countNodes(root.left) + countNodes(root.right);
    };

    const total1 = countNodes(root1);
    const total2 = countNodes(root2);

    return total1 + total2;
};