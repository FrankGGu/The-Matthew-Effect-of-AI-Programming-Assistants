var validateBinaryTreeNodes = function(n, leftChild, rightChild) {
    const inDegree = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        if (leftChild[i] !== -1) {
            inDegree[leftChild[i]]++;
        }
        if (rightChild[i] !== -1) {
            inDegree[rightChild[i]]++;
        }
    }

    let root = -1;
    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            if (root !== -1) {
                // More than one node with in-degree 0 (multiple roots)
                return false;
            }
            root = i;
        } else if (inDegree[i] > 1) {
            // A node has more than one parent
            return false;
        }
    }

    if (root === -1) {
        // No node with in-degree 0 (no root or cycle)
        return false;
    }

    // Perform BFS to check connectivity and ensure all nodes are visited exactly once
    const queue = [root];
    const visited = new Array(n).fill(false);
    visited[root] = true;
    let visitedCount = 1;

    let head = 0;
    while (head < queue.length) {
        const node = queue[head++];

        const children = [leftChild[node], rightChild[node]];

        for (const child of children) {
            if (child !== -1) {
                if (visited[child]) {
                    // Cycle detected or node visited multiple times through different paths
                    // (though in-degree check should handle multiple parents)
                    return false;
                }
                visited[child] = true;
                visitedCount++;
                queue.push(child);
            }
        }
    }

    // All nodes must be reachable from the root
    return visitedCount === n;
};