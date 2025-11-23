function minOperations(boxes) {
    const n = boxes.length;
    const result = new Array(n).fill(0);

    let leftCount = 0, rightCount = 0, leftSum = 0, rightSum = 0;

    for (let i = 0; i < n; i++) {
        result[i] += leftSum;
        leftSum += leftCount;
        leftCount += boxes[i] === '1' ? 1 : 0;
    }

    for (let i = n - 1; i >= 0; i--) {
        result[i] += rightSum;
        rightSum += rightCount;
        rightCount += boxes[i] === '1' ? 1 : 0;
    }

    return result;
}