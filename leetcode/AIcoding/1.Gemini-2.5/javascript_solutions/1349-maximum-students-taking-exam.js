function maxStudents(seats) {
    const m = seats.length;
    const n = seats[0].length;

    const rowMasks = new Array(m);
    for (let i = 0; i < m; i++) {
        rowMasks[i] = [];
        const brokenSeatsMask = seats[i].reduce((acc, char, col) => {
            if (char === '#') {
                return acc | (1 << col);
            }
            return acc;
        }, 0);

        for (let mask = 0; mask < (1 << n); mask++) {
            // Check if no two students are adjacent in the same row (left/right)
            // (mask & (mask >> 1)) == 0
            // Check if no student sits in a broken seat
            // (mask & brokenSeatsMask) == 0
            if (((mask & (mask >> 1)) === 0) && ((mask & brokenSeatsMask) === 0)) {
                rowMasks[i].push(mask);
            }
        }
    }

    // dp[prev_mask] stores max students up to the previous row (i-1)
    // with prev_mask being the configuration of row (i-1).
    // Initialize dp for a conceptual row before row 0, where 0 students are seated.
    let dp = new Array(1 << n).fill(-1);
    dp[0] = 0; // 0 students for an empty previous row (before row 0)

    for (let i = 0; i < m; i++) { // Iterate through rows
        let new_dp = new Array(1 << n).fill(-1);

        for (const current_mask of rowMasks[i]) { // Iterate through valid masks for current row
            const current_students = countSetBits(current_mask);

            for (let prev_mask = 0; prev_mask < (1 << n); prev_mask++) { // Iterate through all possible prev_masks
                if (dp[prev_mask] === -1) {
                    continue; // prev_mask was not reachable or invalid
                }

                // Check compatibility between current_mask and prev_mask:
                // A student cannot sit in a seat that has a student directly to their:
                // 1. Upper-left: (current_mask & (prev_mask >> 1)) == 0
                // 2. Upper-right: (current_mask & (prev_mask << 1)) == 0
                // 3. Directly above: (current_mask & prev_mask) == 0
                const conflict_left_diag = (current_mask & (prev_mask >> 1));
                const conflict_right_diag = (current_mask & (prev_mask << 1));
                const conflict_up = (current_mask & prev_mask);

                if (conflict_left_diag === 0 && conflict_right_diag === 0 && conflict_up === 0) {
                    new_dp[current_mask] = Math.max(new_dp[current_mask], dp[prev_mask] + current_students);
                }
            }
        }
        dp = new_dp; // Update dp for the next row iteration
    }

    let maxTotalStudents = 0;
    for (let mask = 0; mask < (1 << n); mask++) {
        maxTotalStudents = Math.max(maxTotalStudents, dp[mask]);
    }

    return maxTotalStudents;
}

function countSetBits(n) {
    let count = 0;
    while (n > 0) {
        n &= (n - 1); // Brian Kernighan's algorithm
        count++;
    }
    return count;
}