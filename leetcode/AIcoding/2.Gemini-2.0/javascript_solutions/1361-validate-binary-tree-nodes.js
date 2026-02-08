var validateBinaryTreeNodes = function(n, leftChild, rightChild) {
    const parents = new Array(n).fill(-1);

    for (let i = 0; i < n; i++) {
        if (leftChild[i] !== -1) {
            if (parents[leftChild[i]] !== -1) return false;
            parents[leftChild[i]] = i;
        }
        if (rightChild[i] !== -1) {
            if (parents[rightChild[i]] !== -1) return false;
            parents[rightChild[i]] = i;
        }
    }

    let root = -1;
    for (let i = 0; i < n; i++) {
        if (parents[i] === -1) {
            if (root !== -1) return false;
            root = i;
        }
    }

    if (root === -1) return false;

    const visited = new Array(n).fill(false);
    const queue = [root];
    let count = 0;

    while (queue.length > 0) {
        const node = queue.shift();
        if (visited[node]) return false;
        visited[node] = true;
        count++;

        if (leftChild[node] !== -1) {
            queue.push(leftChild[node]);
        }
        if (rightChild[node] !== -1) {
            queue.push(rightChild[node]);
        }
    }

    return count === n;
};