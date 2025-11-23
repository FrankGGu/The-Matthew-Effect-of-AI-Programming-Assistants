var validateBinaryTreeNodes = function(n, leftChild, rightChild) {
    const parent = new Array(n).fill(-1);

    for (let i = 0; i < n; i++) {
        const left = leftChild[i];
        const right = rightChild[i];

        if (left !== -1) {
            if (parent[left] !== -1) return false;
            parent[left] = i;
        }

        if (right !== -1) {
            if (parent[right] !== -1) return false;
            parent[right] = i;
        }
    }

    let root = -1;
    for (let i = 0; i < n; i++) {
        if (parent[i] === -1) {
            if (root !== -1) return false;
            root = i;
        }
    }

    if (root === -1) return false;

    const visited = new Set();
    const queue = [root];

    while (queue.length > 0) {
        const node = queue.shift();
        if (visited.has(node)) return false;
        visited.add(node);

        if (leftChild[node] !== -1) queue.push(leftChild[node]);
        if (rightChild[node] !== -1) queue.push(rightChild[node]);
    }

    return visited.size === n;
};