class TreeNode {
    constructor(val, left, right) {
        this.val = val === undefined ? 0 : val;
        this.left = left === undefined ? null : left;
        this.right = right === undefined ? null : right;
    }
}

var countPairs = function(root, distance) {
    let count = 0;

    const dfs = (node) => {
        if (!node) return [];
        if (!node.left && !node.right) return [1];

        const leftDistances = dfs(node.left);
        const rightDistances = dfs(node.right);

        for (let l of leftDistances) {
            for (let r of rightDistances) {
                if (l + r <= distance) count++;
            }
        }

        const newDistances = [];
        for (let l of leftDistances) {
            if (l + 1 < distance) newDistances.push(l + 1);
        }
        for (let r of rightDistances) {
            if (r + 1 < distance) newDistances.push(r + 1);
        }

        return newDistances;
    };

    dfs(root);
    return count;
};