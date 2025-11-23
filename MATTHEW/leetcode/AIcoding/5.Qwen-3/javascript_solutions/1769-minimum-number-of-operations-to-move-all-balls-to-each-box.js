function minOperations(boxes) {
    const n = boxes.length;
    const result = new Array(n).fill(0);
    let leftCount = 0, leftOps = 0;

    for (let i = 0; i < n; i++) {
        result[i] += leftOps;
        if (boxes[i] === '1') {
            leftCount++;
        }
        leftOps += leftCount;
    }

    let rightCount = 0, rightOps = 0;

    for (let i = n - 1; i >= 0; i--) {
        result[i] += rightOps;
        if (boxes[i] === '1') {
            rightCount++;
        }
        rightOps += rightCount;
    }

    return result;
}