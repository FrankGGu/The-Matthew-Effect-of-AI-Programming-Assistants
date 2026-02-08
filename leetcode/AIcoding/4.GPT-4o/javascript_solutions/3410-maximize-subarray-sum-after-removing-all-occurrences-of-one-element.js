var maximumSum = function(arr) {
    const totalSum = arr.reduce((sum, num) => sum + num, 0);
    const freq = new Map();
    for (const num of arr) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    let maxSum = totalSum;

    for (const num of freq.keys()) {
        let currentSum = totalSum;
        if (freq.get(num) > 0) {
            currentSum -= num * freq.get(num);
            const adjacentNum = num + 1;
            if (freq.has(adjacentNum)) {
                currentSum -= adjacentNum * freq.get(adjacentNum);
            }
            maxSum = Math.max(maxSum, currentSum);
        }
    }

    return maxSum;
};