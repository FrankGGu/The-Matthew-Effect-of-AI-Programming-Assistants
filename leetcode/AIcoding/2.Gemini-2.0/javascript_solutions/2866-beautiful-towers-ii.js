var maximumSumOfHeights = function(maxHeights) {
    const n = maxHeights.length;
    let prefixSums = new Array(n).fill(0);
    let suffixSums = new Array(n).fill(0);

    let stack = [];
    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && maxHeights[stack[stack.length - 1]] >= maxHeights[i]) {
            stack.pop();
        }
        if (stack.length === 0) {
            prefixSums[i] = (i + 1) * maxHeights[i];
        } else {
            prefixSums[i] = prefixSums[stack[stack.length - 1]] + (i - stack[stack.length - 1]) * maxHeights[i];
        }
        stack.push(i);
    }

    stack = [];
    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && maxHeights[stack[stack.length - 1]] >= maxHeights[i]) {
            stack.pop();
        }
        if (stack.length === 0) {
            suffixSums[i] = (n - i) * maxHeights[i];
        } else {
            suffixSums[i] = suffixSums[stack[stack.length - 1]] + (stack[stack.length - 1] - i) * maxHeights[i];
        }
        stack.push(i);
    }

    let maxSum = 0;
    for (let i = 0; i < n; i++) {
        maxSum = Math.max(maxSum, prefixSums[i] + suffixSums[i] - maxHeights[i]);
    }

    return maxSum;
};