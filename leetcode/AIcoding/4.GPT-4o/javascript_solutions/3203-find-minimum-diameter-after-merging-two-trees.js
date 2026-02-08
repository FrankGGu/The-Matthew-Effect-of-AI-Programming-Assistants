class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var findMinimumDiameter = function(root1, root2, M) {
    const getDiameter = (root) => {
        if (!root) return 0;
        let left = getDiameter(root.left);
        let right = getDiameter(root.right);
        return Math.max(left, right) + 1;
    };

    const mergeTrees = (t1, t2) => {
        if (!t1 && !t2) return null;
        if (!t1) return t2;
        if (!t2) return t1;
        let merged = new TreeNode(t1.val + t2.val);
        merged.left = mergeTrees(t1.left, t2.left);
        merged.right = mergeTrees(t1.right, t2.right);
        return merged;
    };

    const mergedTree = mergeTrees(root1, root2);
    let diameter = getDiameter(mergedTree);
    return diameter <= M ? diameter : M;
};