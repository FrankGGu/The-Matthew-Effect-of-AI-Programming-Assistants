var maximumSumOfHeights = function(maxHeight) {
    const n = maxHeight.length;

    const left = new Array(n).fill(0);
    const stackLeft = []; 
    let currentSumLeft = 0;

    for (let i = 0; i < n; i++) {
        while (stackLeft.length > 0 && maxHeight[stackLeft[stackLeft.length - 1]] >= maxHeight[i]) {
            const prevIndex = stackLeft.pop();
            const prevPrevIndex = stackLeft.length > 0 ? stackLeft[stackLeft.length - 1] : -1;
            currentSumLeft -= (maxHeight[prevIndex] * (prevIndex - prevPrevIndex));
        }
        const prevIndex = stackLeft.length > 0 ? stackLeft[stackLeft.length - 1] : -1;
        currentSumLeft += (maxHeight[i] * (i - prevIndex));
        stackLeft.push(i);
        left[i] = currentSumLeft;
    }

    const right = new Array(n).fill(0);
    const stackRight = []; 
    let currentSumRight = 0;

    for (let i = n - 1; i >= 0; i--) {
        while (stackRight.length > 0 && maxHeight[stackRight[stackRight.length - 1]] >= maxHeight[i]) {
            const prevIndex = stackRight.pop();
            const prevPrevIndex = stackRight.length > 0 ? stackRight[stackRight.length - 1] : n;
            currentSumRight -= (maxHeight[prevIndex] * (prevPrevIndex - prevIndex));
        }
        const prevIndex = stackRight.length > 0 ? stackRight[stackRight.length - 1] : n;
        currentSumRight += (maxHeight[i] * (prevIndex - i));
        stackRight.push(i);
        right[i] = currentSumRight;
    }

    let maxSum = 0;
    for (let i = 0; i < n; i++) {
        maxSum = Math.max(maxSum, left[i] + right[i] - maxHeight[i]);
    }

    return maxSum;
};