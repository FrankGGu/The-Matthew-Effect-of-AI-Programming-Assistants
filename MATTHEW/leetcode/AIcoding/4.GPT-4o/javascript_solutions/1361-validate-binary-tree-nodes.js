var validateBinaryTreeNodes = function(n, leftChild, rightChild) {
    const parent = new Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        if (leftChild[i] !== -1) {
            parent[leftChild[i]]++;
        }
        if (rightChild[i] !== -1) {
            parent[rightChild[i]]++;
        }
    }
    const rootCount = parent.filter(p => p === 0).length;
    if (rootCount !== 1) return false;

    const seen = new Set();
    const dfs = (node) => {
        if (node === -1 || seen.has(node)) return true;
        seen.add(node);
        return dfs(leftChild[node]) && dfs(rightChild[node]);
    };

    return dfs(0) && seen.size === n;
};