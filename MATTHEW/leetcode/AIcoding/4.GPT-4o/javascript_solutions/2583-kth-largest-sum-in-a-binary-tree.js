class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var kthLargestLevelSum = function(root, k) {
    const levelSums = [];

    const traverse = (node, depth) => {
        if (!node) return;
        if (levelSums[depth] === undefined) {
            levelSums[depth] = 0;
        }
        levelSums[depth] += node.val;
        traverse(node.left, depth + 1);
        traverse(node.right, depth + 1);
    };

    traverse(root, 0);
    levelSums.sort((a, b) => b - a);

    return k <= levelSums.length ? levelSums[k - 1] : null;
};