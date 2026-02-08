var minimumDifference = function(nums) {
    const n = nums.length / 2;
    const total = nums.reduce((a, b) => a + b, 0);
    const half = Math.floor(total / 2);

    const left = nums.slice(0, n);
    const right = nums.slice(n);

    const leftSums = Array(n + 1).fill().map(() => new Set());
    const rightSums = Array(n + 1).fill().map(() => new Set());

    leftSums[0].add(0);
    rightSums[0].add(0);

    for (let i = 0; i < n; i++) {
        for (let k = i; k >= 0; k--) {
            for (const val of leftSums[k]) {
                leftSums[k + 1].add(val + left[i]);
            }
        }
    }

    for (let i = 0; i < n; i++) {
        for (let k = i; k >= 0; k--) {
            for (const val of rightSums[k]) {
                rightSums[k + 1].add(val + right[i]);
            }
        }
    }

    let minDiff = Infinity;

    for (let k = 0; k <= n; k++) {
        const leftArr = Array.from(leftSums[k]).sort((a, b) => a - b);
        const rightArr = Array.from(rightSums[n - k]).sort((a, b) => a - b);

        let i = 0;
        let j = rightArr.length - 1;

        while (i < leftArr.length && j >= 0) {
            const sum = leftArr[i] + rightArr[j];
            const diff = Math.abs(total - 2 * sum);
            minDiff = Math.min(minDiff, diff);

            if (sum < half) {
                i++;
            } else {
                j--;
            }
        }
    }

    return minDiff;
};