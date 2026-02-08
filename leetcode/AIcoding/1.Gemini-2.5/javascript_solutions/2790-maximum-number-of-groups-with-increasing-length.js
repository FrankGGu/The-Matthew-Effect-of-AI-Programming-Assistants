var maxIncreasingGroups = function(usageLimits) {
    // Sort usageLimits in ascending order.
    // This ensures we prioritize processing items with fewer available counts first.
    // The intuition is that items with smaller limits are more restrictive,
    // so we check if we can satisfy the increasing group length requirements
    // using these limited resources first.
    usageLimits.sort((a, b) => a - b);

    let groups = 0; // Stores the maximum number of groups formed so far
    let currentTotalItemsAvailable = 0; // Accumulates the sum of usageLimits of items processed so far

    // Iterate through the sorted usageLimits array
    for (const limit of usageLimits) {
        currentTotalItemsAvailable += limit;

        // The (groups + 1)-th group needs (groups + 1) distinct items.
        // To form 'groups + 1' groups in total (i.e., groups of length 1, 2, ..., groups + 1),
        // we need a total of 1 + 2 + ... + (groups + 1) "slots" for distinct items.
        // The sum of an arithmetic series 1 to N is N * (N + 1) / 2.
        // So, for 'groups + 1' groups, we need (groups + 1) * (groups + 2) / 2 total slots.
        // If the 'currentTotalItemsAvailable' (sum of limits of items processed so far)
        // is greater than or equal to this required total number of slots,
        // it means we have enough capacity from the items considered so far to form this next group.
        // We can then increment the count of groups.
        if (currentTotalItemsAvailable >= (groups + 1) * (groups + 2) / 2) {
            groups++;
        }
    }

    return groups;
};