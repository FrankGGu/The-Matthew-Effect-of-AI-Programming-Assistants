var numMovesStonesII = function(stones) {
    stones.sort((a, b) => a - b);
    const a = stones[0];
    const b = stones[1];
    const c = stones[2];
    const N = 3;

    // Calculate maximum moves
    // The "not an endpoint stone" constraint means a moved stone must be placed
    // strictly between the other two stones.
    // With 3 stones (a, b, c), this implies:
    // - If we move 'a', its new position 'p' must satisfy b < p < c.
    // - If we move 'c', its new position 'p' must satisfy a < p < b.
    // The middle stone 'b' can never be moved as it's never an endpoint.
    //
    // If the stones are already consecutive (e.g., [1, 2, 3]), no moves are possible.
    // Otherwise, we can always make 2 moves to make them consecutive.
    // Example: [1, 5, 10]
    // 1. Move 'a' (1) to 6 (between 5 and 10). Stones become [5, 6, 10]. (1 move)
    // 2. Move 'c' (10) to 7 (between 5 and 6). Stones become [5, 6, 7]. (1 move)
    // Total 2 moves.
    // Example: [1, 2, 5]
    // 1. Move 'a' (1) to 3 (between 2 and 5). Stones become [2, 3, 5]. (1 move)
    // 2. Move 'c' (5) to 4 (between 2 and 3). Stones become [2, 3, 4]. (1 move)
    // Total 2 moves.
    let maxMoves;
    if (c - a === 2) { // Already consecutive: [x, x+1, x+2]
        maxMoves = 0;
    } else {
        maxMoves = 2;
    }

    // Calculate minimum moves
    // This uses a sliding window approach, common for the general N-stone problem.
    // We want to find a window of size N (which is 3) that contains the maximum number of stones.
    // The minimum moves will be N - (max_stones_in_window).
    // There's a special case: if N-1 stones are tightly packed in a window of size N-1,
    // and the Nth stone is far away (e.g., [1, 2, 5] for N=3).
    // In this scenario, even though N - (N-1) = 1 move might seem possible,
    // the "not an endpoint stone" constraint prevents moving the far stone directly into the gap
    // (e.g., moving 5 to 3 is invalid because 3 is not between 1 and 2).
    // It will take 2 moves instead.
    let minMoves = N; // Initialize with the maximum possible moves (N for general case, 2 for N=3).
    let left = 0;

    for (let right = 0; right < N; right++) {
        // Shrink window from left if current window size exceeds N
        while (stones[right] - stones[left] + 1 > N) {
            left++;
        }

        const stonesInWindow = right - left + 1;

        // Special case: N-1 stones are packed in N-1 positions, and the Nth stone is far away.
        // For N=3, this means 2 stones are adjacent (e.g., [1, 2]), and the 3rd stone (5 in [1,2,5]) is far.
        // The condition `stones[right] - stones[left] + 1 === N - 1` checks if the current window is tightly packed with N-1 stones.
        if (stonesInWindow === N - 1 && stones[right] - stones[left] + 1 === N - 1) {
            minMoves = Math.min(minMoves, 2);
        } else {
            // Standard case: min moves = N - (number of stones in the current best window)
            minMoves = Math.min(minMoves, N - stonesInWindow);
        }
    }

    // If stones are already consecutive, both min and max moves are 0.
    if (c - a === 2) {
        return [0, 0];
    } else {
        return [minMoves, maxMoves];
    }
};