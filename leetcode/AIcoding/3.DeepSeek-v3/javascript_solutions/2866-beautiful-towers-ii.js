var maximumSumOfHeights = function(maxHeights) {
    const n = maxHeights.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);
    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && maxHeights[i] < maxHeights[stack[stack.length - 1]]) {
            stack.pop();
        }
        if (stack.length === 0) {
            left[i] = (i + 1) * maxHeights[i];
        } else {
            const last = stack[stack.length - 1];
            left[i] = left[last] + (i - last) * maxHeights[i];
        }
        stack.push(i);
    }

    stack.length = 0;
    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && maxHeights[i] < maxHeights[stack[stack.length - 1]]) {
            stack.pop();
        }
        if (stack.length === 0) {
            right[i] = (n - i) * maxHeights[i];
        } else {
            const last = stack[stack.length - 1];
            right[i] = right[last] + (last - i) * maxHeights[i];
        }
        stack.push(i);
    }

    let maxSum = 0;
    for (let i = 0; i < n; i++) {
        maxSum = Math.max(maxSum, left[i] + right[i] - maxHeights[i]);
    }

    return maxSum;
};