var maximumSumOfHeights = function(maxHeights) {
    const n = maxHeights.length;
    let maxSum = 0;

    const leftSums = new Array(n).fill(0);
    const rightSums = new Array(n).fill(0);

    let stack = [];
    let currentSum = 0;
    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && maxHeights[stack[stack.length - 1]] >= maxHeights[i]) {
            const j = stack.pop();
            const prevJIdx = stack.length === 0 ? -1 : stack[stack.length - 1];
            currentSum -= (j - prevJIdx) * maxHeights[j];
        }
        const prevIdx = stack.length === 0 ? -1 : stack[stack.length - 1];
        currentSum += (i - prevIdx) * maxHeights[i];
        leftSums[i] = currentSum;
        stack.push(i);
    }

    stack = [];
    currentSum = 0;
    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && maxHeights[stack[stack.length - 1]] >= maxHeights[i]) {
            const j = stack.pop();
            const nextJIdx = stack.length === 0 ? n : stack[stack.length - 1];
            currentSum -= (nextJIdx - j) * maxHeights[j];
        }
        const nextIdx = stack.length === 0 ? n : stack[stack.length - 1];
        currentSum += (nextIdx - i) * maxHeights[i];
        rightSums[i] = currentSum;
        stack.push(i);
    }

    for (let i = 0; i < n; i++) {
        maxSum = Math.max(maxSum, leftSums[i] + rightSums[i] - maxHeights[i]);
    }

    return maxSum;
};