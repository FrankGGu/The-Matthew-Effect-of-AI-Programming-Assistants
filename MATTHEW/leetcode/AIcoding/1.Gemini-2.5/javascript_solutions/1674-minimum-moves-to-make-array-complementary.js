var minMoves = function(nums, limit) {
    const n = nums.length;
    // The possible sums k range from 2 (1+1) to 2*limit (limit+limit).
    // The diff array will store changes in the number of moves needed for each sum.
    // Index 0 and 1 are unused as the minimum sum is 2.
    // The maximum possible sum is 2 * limit.
    // We need an array of size (2 * limit + 2) to handle indices up to (2 * limit + 1).
    const diff = new Array(2 * limit + 2).fill(0);

    // Process each pair (nums[i], nums[n - 1 - i])
    for (let i = 0; i < n / 2; i++) {
        let a = nums[i];
        let b = nums[n - 1 - i];

        // Ensure a <= b for consistent logic
        if (a > b) {
            [a, b] = [b, a];
        }

        // 1. Initial cost: Any target sum k from 2 to 2*limit can be achieved by changing both a and b.
        // This costs 2 moves. So, we add 2 to the starting point of this range.
        diff[2] += 2;
        // And subtract 2 from the point just after the range to cancel its effect.
        diff[2 * limit + 1] -= 2;

        // 2. Cost 1 move: Target sums k in the range [a + 1, b + limit] can be achieved by changing only one of a or b.
        // This reduces the cost by 1 from the baseline of 2 moves.
        diff[a + 1] -= 1;
        diff[b + limit + 1] += 1;

        // 3. Cost 0 moves: Target sum k = a + b requires no changes.
        // This further reduces the cost by 1 from the 1-move cost.
        diff[a + b] -= 1;
        diff[a + b + 1] += 1;
    }

    let currentMoves = 0;
    let minMoves = Infinity;

    // Perform the sweep to calculate the actual number of moves for each sum k.
    // Iterate through all possible sums k from 2 to 2*limit.
    for (let k = 2; k <= 2 * limit; k++) {
        currentMoves += diff[k];
        minMoves = Math.min(minMoves, currentMoves);
    }

    return minMoves;
};