var minCost = function(nums, cost) {
    const n = nums.length;

    // Create pairs of (num, cost) and sort them by num
    const pairs = [];
    for (let i = 0; i < n; i++) {
        pairs.push({ num: nums[i], cost: cost[i] });
    }

    pairs.sort((a, b) => a.num - b.num);

    // Calculate the total sum of all costs
    let totalCostSum = 0n; // Use BigInt for sum of costs as it can exceed Number.MAX_SAFE_INTEGER
    for (let i = 0; i < n; i++) {
        totalCostSum += BigInt(pairs[i].cost);
    }

    // Calculate the initial cost with the target set to the first number in the sorted array
    let currentCost = 0n; // Use BigInt for cost as it can exceed Number.MAX_SAFE_INTEGER
    for (let i = 0; i < n; i++) {
        currentCost += BigInt(pairs[i].cost) * BigInt(Math.abs(pairs[i].num - pairs[0].num));
    }

    let minCost = currentCost;

    // leftCostSum tracks the sum of costs for numbers less than or equal to the current target (pairs[k-1].num)
    let leftCostSum = BigInt(pairs[0].cost);

    // Iterate through the sorted numbers, moving the target from pairs[k-1].num to pairs[k].num
    for (let k = 1; k < n; k++) {
        const deltaX = BigInt(pairs[k].num - pairs[k-1].num);

        // Calculate the change in cost:
        // For elements with nums[j] <= pairs[k-1].num (sum of costs = leftCostSum), their contribution increases by deltaX * cost[j].
        // For elements with nums[j] > pairs[k-1].num (sum of costs = totalCostSum - leftCostSum), their contribution decreases by deltaX * cost[j].
        // Net change = (leftCostSum * deltaX) - ((totalCostSum - leftCostSum) * deltaX)
        //           = (leftCostSum - (totalCostSum - leftCostSum)) * deltaX
        const change = (leftCostSum - (totalCostSum - leftCostSum)) * deltaX;

        currentCost += change;

        // Update minCost if currentCost is smaller
        minCost = minCost < currentCost ? minCost : currentCost;

        // Add the cost of the current number (pairs[k].num) to leftCostSum for the next iteration
        leftCostSum += BigInt(pairs[k].cost);
    }

    // The problem specifies a 'number' return type, so convert BigInt back to Number.
    // This assumes the final minimum cost will fit within standard JavaScript number precision,
    // or LeetCode's environment handles large numbers implicitly.
    return Number(minCost);
};