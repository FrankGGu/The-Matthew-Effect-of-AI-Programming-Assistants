var generateTrees = function(n) {
    if (n === 0) return [];
    return generate(1, n);
};

function generate(start, end) {
    let trees = [];
    if (start > end) {
        trees.push(null);
        return trees;
    }
    for (let i = start; i <= end; i++) {
        let leftTrees = generate(start, i - 1);
        let rightTrees = generate(i + 1, end);
        for (let left of leftTrees) {
            for (let right of rightTrees) {
                let root = new TreeNode(i);
                root.left = left;
                root.right = right;
                trees.push(root);
            }
        }
    }
    return trees;
}