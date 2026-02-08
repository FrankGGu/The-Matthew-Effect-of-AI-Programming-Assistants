class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var smallestMissingValue = function(root) {
    const result = [];

    function dfs(node) {
        if (!node) return new Set();

        const leftValues = dfs(node.left);
        const rightValues = dfs(node.right);

        const allValues = new Set([...leftValues, ...rightValues, node.val]);
        let missingValue = 1;

        while (allValues.has(missingValue)) {
            missingValue++;
        }

        result.push(missingValue);
        return allValues;
    }

    dfs(root);
    return result;
};