var minAbsDifference = function(nums, goal) {
    const n = nums.length;
    const mid = Math.floor(n / 2);

    const generateSums = (index, currentSum, arr, sumsSet) => {
        if (index === arr.length) {
            sumsSet.add(currentSum);
            return;
        }
        generateSums(index + 1, currentSum + arr[index], arr, sumsSet);
        generateSums(index + 1, currentSum, arr, sumsSet);
    };

    const leftHalf = nums.slice(0, mid);
    const rightHalf = nums.slice(mid);

    const sums1Set = new Set();
    generateSums(0, 0, leftHalf, sums1Set);
    const sums1 = Array.from(sums1Set);

    const sums2Set = new Set();
    generateSums(0, 0, rightHalf, sums2Set);
    const sums2 = Array.from(sums2Set);
    sums2.sort((a, b) => a - b);

    let minDiff = Math.abs(goal);

    const lowerBound = (arr, target) => {
        let low = 0;
        let high = arr.length;
        while (low < high) {
            let midIdx = Math.floor((low + high) / 2);
            if (arr[midIdx] < target) {
                low = midIdx + 1;
            } else {
                high = midIdx;
            }
        }
        return low;
    };

    for (const s1 of sums1) {
        const target = goal - s1;
        const idx = lowerBound(sums2, target);

        if (idx < sums2.length) {
            minDiff = Math.min(minDiff, Math.abs(s1 + sums2[idx] - goal));
        }
        if (idx > 0) {
            minDiff = Math.min(minDiff, Math.abs(s1 + sums2[idx - 1] - goal));
        }
    }

    return minDiff;
};