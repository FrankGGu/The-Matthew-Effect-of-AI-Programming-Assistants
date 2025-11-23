var minAbsDifference = function(nums, goal) {
    const n = nums.length;
    const firstHalf = nums.slice(0, n / 2);
    const secondHalf = nums.slice(n / 2);

    const sums1 = new Set();
    const sums2 = new Set();

    function generateSums(arr, sums) {
        const m = arr.length;
        for (let i = 0; i < (1 << m); i++) {
            let sum = 0;
            for (let j = 0; j < m; j++) {
                if ((i >> j) & 1) {
                    sum += arr[j];
                }
            }
            sums.add(sum);
        }
    }

    generateSums(firstHalf, sums1);
    generateSums(secondHalf, sums2);

    const sortedSums2 = Array.from(sums2).sort((a, b) => a - b);

    let minDiff = Infinity;
    for (const sum1 of sums1) {
        const target = goal - sum1;
        let left = 0;
        let right = sortedSums2.length - 1;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            minDiff = Math.min(minDiff, Math.abs(target - sortedSums2[mid]));

            if (sortedSums2[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
    }

    return minDiff;
};