var minimumDifference = function(nums) {
    const n = nums.length / 3;
    let left = nums.slice(0, 2 * n);
    let right = nums.slice(n);

    let leftSums = new Array(n + 1).fill(Infinity);
    leftSums[0] = 0;
    let leftQueue = [];
    let leftSum = 0;

    for (let i = 0; i < 2 * n; i++) {
        leftQueue.push(nums[i]);
        leftSum += nums[i];
        if (leftQueue.length > n) {
            leftQueue.sort((a, b) => b - a);
            leftSum -= leftQueue.shift();
        }
        if (leftQueue.length === n) {
            leftSums[i - n + 1] = leftSum;
        }
    }

    let rightSums = new Array(n + 1).fill(-Infinity);
    rightSums[0] = 0;
    let rightQueue = [];
    let rightSum = 0;

    for (let i = 2 * n - 1; i >= n; i--) {
        rightQueue.push(nums[i]);
        rightSum += nums[i];
        if (rightQueue.length > n) {
            rightQueue.sort((a, b) => a - b);
            rightSum -= rightQueue.shift();
        }
        if (rightQueue.length === n) {
            rightSums[2 * n - 1 - i] = rightSum;
        }
    }

    let minDiff = Infinity;
    for (let i = 0; i <= n; i++) {
        minDiff = Math.min(minDiff, leftSums[i] - rightSums[2 * n - n - i]);
    }

    return minDiff;
};