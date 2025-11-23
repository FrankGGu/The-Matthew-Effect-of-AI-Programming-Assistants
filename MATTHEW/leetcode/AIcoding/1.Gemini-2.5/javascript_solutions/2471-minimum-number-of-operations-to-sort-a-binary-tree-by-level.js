var minimumOperations = function(root) {
    let totalSwaps = 0;
    let queue = [];

    if (root) {
        queue.push(root);
    }

    while (queue.length > 0) {
        let levelSize = queue.length;
        let currentLevelValues = [];

        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            currentLevelValues.push(node.val);

            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }
        totalSwaps += minSwapsToSort(currentLevelValues);
    }

    return totalSwaps;
};

function minSwapsToSort(arr) {
    const n = arr.length;
    if (n <= 1) {
        return 0;
    }

    const arrPos = [];
    for (let i = 0; i < n; i++) {
        arrPos.push({ val: arr[i], idx: i });
    }

    arrPos.sort((a, b) => a.val - b.val);

    const visited = new Array(n).fill(false);
    let swaps = 0;

    for (let i = 0; i < n; i++) {
        if (visited[i] || arrPos[i].idx === i) {
            continue;
        }

        let cycleSize = 0;
        let j = i;
        while (!visited[j]) {
            visited[j] = true;
            j = arrPos[j].idx;
            cycleSize++;
        }
        swaps += (cycleSize - 1);
    }
    return swaps;
}