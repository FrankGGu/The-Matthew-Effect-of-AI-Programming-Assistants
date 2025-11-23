var minOperations = function(boxes) {
    const n = boxes.length;
    const answer = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        let currentOperations = 0;
        for (let j = 0; j < n; j++) {
            if (boxes[j] === '1') {
                currentOperations += Math.abs(i - j);
            }
        }
        answer[i] = currentOperations;
    }

    return answer;
};