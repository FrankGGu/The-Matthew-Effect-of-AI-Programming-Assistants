function mctOfBinaryTree(arr) {
    function buildTree(arr) {
        if (arr.length === 0) return null;
        if (arr.length === 1) return new TreeNode(arr[0]);

        let minCost = Infinity;
        let index = -1;

        for (let i = 0; i < arr.length - 1; i++) {
            let cost = arr[i] * arr[i + 1];
            if (cost < minCost) {
                minCost = cost;
                index = i;
            }
        }

        let left = buildTree(arr.slice(0, index + 1));
        let right = buildTree(arr.slice(index + 1));

        let root = new TreeNode(minCost);
        root.left = left;
        root.right = right;

        return root;
    }

    return buildTree(arr);
}

function TreeNode(val, left, right) {
    this.val = (val === undefined ? 0 : val);
    this.left = (left === undefined ? null : left);
    this.right = (right === undefined ? null : right);
}