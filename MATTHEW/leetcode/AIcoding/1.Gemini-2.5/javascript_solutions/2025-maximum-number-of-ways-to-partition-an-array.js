var waysToPartition = function(nums) {
    const n = nums.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    const totalSum = prefixSum[n];
    let maxWays = 0;

    // Case 1: No change
    if (totalSum % 2 === 0) {
        const target = totalSum / 2;
        let currentWays = 0;
        for (let p = 0; p < n - 1; p++) {
            if (prefixSum[p + 1] === target) {
                currentWays++;
            }
        }
        maxWays = currentWays;
    }

    // Case 2: One change
    // Iterate through each index i where nums[i] is changed.
    // For a fixed i, we need to find an optimal k.
    // The optimal k will make the new total sum S_new = totalSum - nums[i] + k.
    // S_new must be even, say 2 * T. So T = (totalSum - nums[i] + k) / 2.
    // A partition at p is valid if:
    // 1. p < i: prefixSum[p+1] == T
    // 2. p >= i: (prefixSum[p+1] - nums[i] + k) == T  => prefixSum[p+1] == T + nums[i] - k
    // Substitute k = 2T - (totalSum - nums[i]) into the second case:
    // prefixSum[p+1] == T + nums[i] - (2T - totalSum + nums[i])
    // => prefixSum[p+1] == T + nums[i] - 2T + totalSum - nums[i]
    // => prefixSum[p+1] == totalSum - T
    // So for a fixed i, we need to find T that maximizes:
    // (count of p < i such that prefixSum[p+1] == T) + (count of p >= i such that prefixSum[p+1] == totalSum - T)

    const leftFreq = new Map(); // Stores counts for prefixSum[j] where j <= i (i.e., prefixSum[1]...prefixSum[i])
    const rightFreq = new Map(); // Stores counts for prefixSum[j] where j > i (i.e., prefixSum[i+1]...prefixSum[n-1])

    // Initialize rightFreq with all possible partition sums (prefixSum[1] to prefixSum[n-1])
    for (let p = 0; p < n - 1; p++) {
        rightFreq.set(prefixSum[p + 1], (rightFreq.get(prefixSum[p + 1]) || 0) + 1);
    }

    // Iterate through each index i where nums[i] is changed
    // i ranges from 0 to n-1.
    for (let i = 0; i < n; i++) {
        // At this point:
        // leftFreq contains counts for prefixSum[1]...prefixSum[i]
        // rightFreq contains counts for prefixSum[i+1]...prefixSum[n-1]

        let currentWaysForThisChange = 0;

        // Collect all unique sums that could potentially be T or (totalSum - T)
        // This set will contain at most 2*(n-1) distinct values.
        const possibleTargetSums = new Set();
        for (const key of leftFreq.keys()) {
            possibleTargetSums.add(key);
            possibleTargetSums.add(totalSum - key);
        }
        for (const key of rightFreq.keys()) {
            possibleTargetSums.add(key);
            possibleTargetSums.add(totalSum - key);
        }

        // For each possible target sum T, calculate the number of ways
        for (const T of possibleTargetSums) {
            let count = 0;
            // Count partitions p < i where prefixSum[p+1] == T
            count += (leftFreq.get(T) || 0);
            // Count partitions p >= i where prefixSum[p+1] == totalSum - T
            count += (rightFreq.get(totalSum - T) || 0);
            currentWaysForThisChange = Math.max(currentWaysForThisChange, count);
        }

        maxWays = Math.max(maxWays, currentWaysForThisChange);

        // Prepare for the next iteration (i+1):
        // Move prefixSum[i+1] (which is the sum up to nums[i]) from rightFreq to leftFreq.
        // This update is done only if i is not the last element, as prefixSum[n] is not a partition point.
        if (i < n - 1) {
            const valToMove = prefixSum[i + 1];

            // Decrement from rightFreq
            rightFreq.set(valToMove, rightFreq.get(valToMove) - 1);
            if (rightFreq.get(valToMove) === 0) {
                rightFreq.delete(valToMove);
            }

            // Increment in leftFreq
            leftFreq.set(valToMove, (leftFreq.get(valToMove) || 0) + 1);
        }
    }

    return maxWays;
};