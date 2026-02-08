var minimumOperations = function(root) {
    if (!root) return 0;
    let queue = [root];
    let operations = 0;

    while (queue.length > 0) {
        let levelSize = queue.length;
        let level = [];
        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            level.push(node.val);
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }
        let sorted = [...level].sort((a, b) => a - b);
        let indexMap = new Map();
        for (let i = 0; i < sorted.length; i++) {
            indexMap.set(sorted[i], i);
        }
        let visited = new Array(level.length).fill(false);
        for (let i = 0; i < level.length; i++) {
            if (!visited[i]) {
                let j = i;
                let cycleSize = 0;
                while (!visited[j]) {
                    visited[j] = true;
                    j = indexMap.get(level[j]);
                    cycleSize++;
                }
                operations += cycleSize - 1;
            }
        }
    }
    return operations;
};