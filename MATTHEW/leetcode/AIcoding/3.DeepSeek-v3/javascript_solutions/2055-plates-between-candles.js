var platesBetweenCandles = function(s, queries) {
    const n = s.length;
    const prefixSum = new Array(n).fill(0);
    const leftCandle = new Array(n).fill(-1);
    const rightCandle = new Array(n).fill(-1);

    let sum = 0;
    let lastCandle = -1;
    for (let i = 0; i < n; i++) {
        if (s[i] === '*') {
            sum++;
        } else {
            lastCandle = i;
        }
        prefixSum[i] = sum;
        leftCandle[i] = lastCandle;
    }

    lastCandle = -1;
    for (let i = n - 1; i >= 0; i--) {
        if (s[i] === '|') {
            lastCandle = i;
        }
        rightCandle[i] = lastCandle;
    }

    const result = [];
    for (const [left, right] of queries) {
        const leftBound = rightCandle[left];
        const rightBound = leftCandle[right];
        if (leftBound === -1 || rightBound === -1 || leftBound >= rightBound) {
            result.push(0);
        } else {
            result.push(prefixSum[rightBound] - prefixSum[leftBound]);
        }
    }
    return result;
};