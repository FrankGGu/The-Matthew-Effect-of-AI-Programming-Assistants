function kthLargestSum(root, k) {
    const queue = [root];
    const sums = [];

    while (queue.length > 0) {
        let levelSize = queue.length;
        let levelSum = 0;

        for (let i = 0; i < levelSize; i++) {
            const node = queue.shift();
            levelSum += node.val;

            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        sums.push(levelSum);
    }

    sums.sort((a, b) => b - a);
    return sums[k - 1];
}