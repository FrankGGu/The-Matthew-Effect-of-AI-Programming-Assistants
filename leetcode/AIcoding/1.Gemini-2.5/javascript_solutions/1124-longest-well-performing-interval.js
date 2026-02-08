var longestWellPerformingInterval = function(hours) {
    const n = hours.length;
    const nums = new Array(n);
    for (let i = 0; i < n; i++) {
        nums[i] = hours[i] > 8 ? 1 : -1;
    }

    const prefixSums = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSums[i + 1] = prefixSums[i] + nums[i];
    }

    const stack = []; 
    for (let k = 0; k <= n; k++) {
        if (stack.length === 0 || prefixSums[k] < prefixSums[stack[stack.length - 1]]) {
            stack.push(k);
        }
    }

    let maxLen = 0;
    for (let k = n; k >= 0; k--) {
        while (stack.length > 0 && prefixSums[k] > prefixSums[stack[stack.length - 1]]) {
            maxLen = Math.max(maxLen, k - stack.pop());
        }
    }

    return maxLen;
};