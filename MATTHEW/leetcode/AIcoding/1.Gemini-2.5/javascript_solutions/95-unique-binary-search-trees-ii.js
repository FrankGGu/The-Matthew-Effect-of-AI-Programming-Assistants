function TreeNode(val, left, right) {
    this.val = (val === undefined ? 0 : val);
    this.left = (left === undefined ? null : left);
    this.right = (right === undefined ? null : right);
}

var generateTrees = function(n) {
    if (n === 0) {
        return [];
    }

    function generateTreesRecursive(start, end) {
        if (start > end) {
            return [null];
        }

        const allTrees = [];
        for (let i = start; i <= end; i++) {
            const leftSubtrees = generateTreesRecursive(start, i - 1);
            const rightSubtrees = generateTreesRecursive(i + 1, end);

            for (const left of leftSubtrees) {
                for (const right of rightSubtrees) {
                    const currentNode = new TreeNode(i);
                    currentNode.left = left;
                    currentNode.right = right;
                    allTrees.push(currentNode);
                }
            }
        }
        return allTrees;
    }

    return generateTreesRecursive(1, n);
};