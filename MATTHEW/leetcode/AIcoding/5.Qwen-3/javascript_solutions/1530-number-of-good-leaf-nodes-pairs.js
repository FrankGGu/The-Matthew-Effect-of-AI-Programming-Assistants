function TreeNode(val, left, right) {
    this.val = (val === undefined ? 0 : val);
    this.left = (left === undefined ? null : left);
    this.right = (right === undefined ? null : right);
}

var countPairs = function(root) {
    let count = 0;

    const dfs = (node) => {
        if (!node) return [];

        if (!node.left && !node.right) {
            return [1];
        }

        const left = dfs(node.left);
        const right = dfs(node.right);

        for (let l of left) {
            for (let r of right) {
                if (l + r <= 1000) {
                    count++;
                }
            }
        }

        const combined = [...left, ...right].map(x => x + 1);
        return combined;
    };

    dfs(root);
    return count;
};