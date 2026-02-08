var minOperations = function(boxes) {
    const n = boxes.length;
    const result = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (boxes[j] === '1') {
                result[i] += Math.abs(j - i);
            }
        }
    }

    return result;
};