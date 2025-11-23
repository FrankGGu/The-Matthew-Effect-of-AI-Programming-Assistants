var minimumOperations = function(root) {
    let queue = [root];
    let operations = 0;

    while (queue.length > 0) {
        let levelSize = queue.length;
        let levelValues = [];
        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            levelValues.push(node.val);

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }

        operations += minSwaps(levelValues);
    }

    return operations;

    function minSwaps(arr) {
        let n = arr.length;
        let arrpos = [];
        for (let i = 0; i < n; i++) {
            arrpos.push([arr[i], i]);
        }

        arrpos.sort((a, b) => a[0] - b[0]);

        let visited = new Array(n).fill(false);
        let ans = 0;

        for (let i = 0; i < n; i++) {
            if (visited[i] || arrpos[i][1] == i) {
                continue;
            }

            let cycleSize = 0;
            let j = i;
            while (!visited[j]) {
                visited[j] = true;
                j = arrpos[j][1];
                cycleSize++;
            }

            if (cycleSize > 0) {
                ans += (cycleSize - 1);
            }
        }

        return ans;
    }
};