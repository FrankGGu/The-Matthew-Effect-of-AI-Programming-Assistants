class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var minimumOperations = function(root) {
    if (!root) return 0;

    let queue = [root];
    let operations = 0;

    while (queue.length) {
        let levelSize = queue.length;
        let levelValues = [];

        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            levelValues.push(node.val);
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        let sortedValues = [...levelValues].sort((a, b) => a - b);
        let indexMap = new Map();

        levelValues.forEach((val, index) => {
            indexMap.set(val, index);
        });

        let visited = new Array(levelSize).fill(false);
        let swaps = 0;

        for (let i = 0; i < levelSize; i++) {
            if (visited[i] || levelValues[i] === sortedValues[i]) continue;

            let cycleSize = 0;
            let j = i;

            while (!visited[j]) {
                visited[j] = true;
                j = indexMap.get(sortedValues[j]);
                cycleSize++;
            }

            if (cycleSize > 0) {
                swaps += (cycleSize - 1);
            }
        }

        operations += swaps;
    }

    return operations;
};