var minOperations = function(boxes) {
    const n = boxes.length;
    const result = new Array(n).fill(0);

    let leftCount = 0, rightCount = 0, leftOps = 0, rightOps = 0;

    for (let i = 0; i < n; i++) {
        result[i] += leftOps + leftCount;
        leftCount += boxes[i] === '1' ? 1 : 0;
        leftOps += leftCount;
    }

    for (let i = n - 1; i >= 0; i--) {
        result[i] += rightOps + rightCount;
        rightCount += boxes[i] === '1' ? 1 : 0;
        rightOps += rightCount;
    }

    return result;
};