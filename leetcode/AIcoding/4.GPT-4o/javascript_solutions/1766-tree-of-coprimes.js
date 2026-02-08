class TreeNode {
    constructor(val) {
        this.val = val;
        this.left = null;
        this.right = null;
    }
}

var getCoprimes = function(root, nums) {
    const result = [];
    const parent = new Map();
    const coprimeMap = new Map();

    const dfs = (node, p) => {
        if (!node) return;
        parent.set(node.val, p);
        dfs(node.left, node.val);
        dfs(node.right, node.val);
    };

    dfs(root, -1);

    const findCoprimes = (node) => {
        const seen = new Set();
        let curr = node;
        while (curr !== -1) {
            seen.add(nums[curr]);
            curr = parent.get(curr);
        }
        return Array.from(seen).filter((x, i) => {
            for (let j = 0; j < i; j++)
                if (gcd(x, Array.from(seen)[j]) !== 1) return false;
            return true;
        });
    };

    const gcd = (a, b) => b === 0 ? a : gcd(b, a % b);

    const traverse = (node) => {
        if (!node) return;
        let coprimes = findCoprimes(node.val);
        result.push(coprimes.length ? coprimes : [-1]);
        traverse(node.left);
        traverse(node.right);
    };

    traverse(root);
    return result;
};