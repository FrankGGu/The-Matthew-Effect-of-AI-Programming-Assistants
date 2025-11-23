var closestSubsequenceSum = function(nums, goal) {
    const n = nums.length;
    const half = Math.floor(n / 2);
    const leftSums = new Set();
    const rightSums = new Set();

    const generateSums = (arr, start, end) => {
        const sums = new Set();
        const len = end - start;
        for (let mask = 0; mask < (1 << len); mask++) {
            let sum = 0;
            for (let i = 0; i < len; i++) {
                if (mask & (1 << i)) {
                    sum += arr[start + i];
                }
            }
            sums.add(sum);
        }
        return sums;
    };

    const leftPart = generateSums(nums, 0, half);
    const rightPart = generateSums(nums, half, n);

    leftSums = Array.from(leftPart);
    rightSums = Array.from(rightPart).sort((a, b) => a - b);

    let closest = Infinity;

    for (let sum of leftSums) {
        const target = goal - sum;
        let left = 0;
        let right = rightSums.length - 1;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            const currentSum = sum + rightSums[mid];
            if (currentSum === goal) {
                return goal;
            }
            if (Math.abs(currentSum - goal) < Math.abs(closest - goal)) {
                closest = currentSum;
            }
            if (currentSum < goal) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
    }

    return closest;
};