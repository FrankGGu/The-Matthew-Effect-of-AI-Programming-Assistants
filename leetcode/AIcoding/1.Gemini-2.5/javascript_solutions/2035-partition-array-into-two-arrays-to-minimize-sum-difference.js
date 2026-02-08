var minSumDiff = function(nums) {
    const n_half = nums.length / 2;
    const totalSum = nums.reduce((a, b) => a + b, 0);

    const firstHalf = nums.slice(0, n_half);
    const secondHalf = nums.slice(n_half);

    const sums1 = new Map(); // k -> Set<sum>
    const sums2 = new Map(); // k -> Set<sum>

    function generateSums(arr, index, count, currentSum, targetCount, resultsMap) {
        if (index === targetCount) {
            if (!resultsMap.has(count)) {
                resultsMap.set(count, new Set());
            }
            resultsMap.get(count).add(currentSum);
            return;
        }

        generateSums(arr, index + 1, count + 1, currentSum + arr[index], targetCount, resultsMap);
        generateSums(arr, index + 1, count, currentSum, targetCount, resultsMap);
    }

    generateSums(firstHalf, 0, 0, 0, n_half, sums1);
    generateSums(secondHalf, 0, 0, 0, n_half, sums2);

    let minAbsDiff = Infinity;

    for (let k = 0; k <= n_half; k++) {
        const currentSums1 = sums1.get(k);
        const currentSums2 = sums2.get(n_half - k);

        if (!currentSums1 || !currentSums2) {
            continue;
        }

        const arr2 = Array.from(currentSums2).sort((a, b) => a - b);

        for (const s1_part1 of currentSums1) {
            const target_s2 = (totalSum / 2) - s1_part1;

            let low = 0;
            let high = arr2.length - 1;
            let idx = arr2.length; 

            while (low <= high) {
                const mid = Math.floor((low + high) / 2);
                if (arr2[mid] >= target_s2) {
                    idx = mid;
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            }

            if (idx < arr2.length) {
                const s1 = s1_part1 + arr2[idx];
                minAbsDiff = Math.min(minAbsDiff, Math.abs(2 * s1 - totalSum));
            }

            if (idx > 0) {
                const s1 = s1_part1 + arr2[idx - 1];
                minAbsDiff = Math.min(minAbsDiff, Math.abs(2 * s1 - totalSum));
            }
        }
    }

    return minAbsDiff;
};