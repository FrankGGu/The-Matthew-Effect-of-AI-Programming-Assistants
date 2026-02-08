class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var averageOfSubtree = function(root) {
    let count = 0;

    const dfs = (node) => {
        if (!node) return [0, 0];
        const [leftSum, leftCount] = dfs(node.left);
        const [rightSum, rightCount] = dfs(node.right);
        const totalSum = leftSum + rightSum + node.val;
        const totalCount = leftCount + rightCount + 1;

        if (Math.floor(totalSum / totalCount) === node.val) {
            count++;
        }

        return [totalSum, totalCount];
    };

    dfs(root);
    return count;
};