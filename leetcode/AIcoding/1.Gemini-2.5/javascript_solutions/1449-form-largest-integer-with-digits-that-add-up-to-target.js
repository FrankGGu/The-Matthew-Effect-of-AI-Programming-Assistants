var largestNumber = function(cost, target) {
    // dp[i] will store the maximum number of digits (length) that can be formed with total cost i.
    // Initialize with -Infinity to indicate that a cost is not reachable.
    // dp[0] is 0 because a cost of 0 can be achieved with 0 digits (an empty number).
    const dp = new Array(target + 1).fill(-Infinity);
    dp[0] = 0;

    // Populate the dp array
    // Iterate through each possible target cost from 1 to 'target'
    for (let t = 1; t <= target; t++) {
        // Iterate through each digit from 1 to 9 (index 0 to 8 in the cost array)
        for (let d = 1; d <= 9; d++) {
            const currentCost = cost[d - 1];

            // If the current cost 't' is less than the cost of digit 'd',
            // or if the remaining cost (t - currentCost) is not reachable, skip.
            if (t < currentCost || dp[t - currentCost] === -Infinity) {
                continue;
            }

            // Update dp[t] with the maximum length.
            // We can form a number of length dp[t - currentCost] + 1 by using digit 'd'.
            dp[t] = Math.max(dp[t], dp[t - currentCost] + 1);
        }
    }

    // If dp[target] is still -Infinity, it means no number can be formed for the given target.
    if (dp[target] === -Infinity) {
        return "0";
    }

    // Reconstruct the largest number string using the dp array.
    // We prioritize digits from 9 down to 1 to ensure the lexicographically largest number.
    let result = "";
    let currentTarget = target;

    // Iterate while there's still target cost to account for
    while (currentTarget > 0) {
        // Try digits from 9 down to 1
        for (let d = 9; d >= 1; d--) {
            const c = cost[d - 1];

            // Check if using digit 'd' is possible AND it leads to a path that
            // maintains the maximum length for the currentTarget.
            // This means:
            // 1. currentTarget is sufficient for cost 'c'.
            // 2. The remaining cost (currentTarget - c) must have been able to form a number
            //    whose length is exactly one less than the max length for currentTarget.
            if (currentTarget >= c && dp[currentTarget - c] === dp[currentTarget] - 1) {
                result += String(d); // Append the digit
                currentTarget -= c;   // Reduce the target cost
                break;                // Move to find the next digit for the reduced target
            }
        }
    }

    return result;
};