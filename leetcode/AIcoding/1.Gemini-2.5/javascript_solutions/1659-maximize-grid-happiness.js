var getMaxGridHappiness = function(m, n, introverts, extroverts) {
    // Happiness values for placing people
    const H_I = 120;
    const H_E = 40;

    // Adjacency happiness values
    const ADJ_II = -30;
    const ADJ_EE = 40;
    const ADJ_IE = -10;

    // Adjacency matrix: adj_matrix[person1_type][person2_type]
    // 0: empty, 1: introvert, 2: extrovert
    const adj_matrix = [
        [0, 0, 0],         // Row for empty cells
        [0, ADJ_II, ADJ_IE], // Row for introvert cells
        [0, ADJ_IE, ADJ_EE]  // Row for extrovert cells
    ];

    // Precompute powers of 3 for mask manipulation
    // pow3[i] = 3^i
    const pow3 = new Array(n + 1);
    pow3[0] = 1;
    for (let i = 1; i <= n; i++) {
        pow3[i] = pow3[i - 1] * 3;
    }

    // Maximum possible mask value (3^n - 1)
    const max_mask_val = pow3[n];

    // Helper to get person type at a specific column in a mask
    // Returns 0: empty, 1: introvert, 2: extrovert
    const getPersonType = (mask, col) => {
        return Math.floor(mask / pow3[col]) % 3;
    };

    // Precompute properties for each possible mask (row configuration)
    // This stores the number of introverts, extroverts, and internal happiness
    // (base happiness + horizontal adjacencies) for each mask.
    const mask_info = new Array(max_mask_val);
    for (let mask = 0; mask < max_mask_val; mask++) {
        let current_intro_count = 0;
        let current_extro_count = 0;
        let internal_happiness = 0;

        for (let col = 0; col < n; col++) {
            const s = getPersonType(mask, col);
            if (s === 1) { // Introvert
                current_intro_count++;
                internal_happiness += H_I;
            } else if (s === 2) { // Extrovert
                current_extro_count++;
                internal_happiness += H_E;
            }

            // Check horizontal adjacency with the cell to the left
            if (col > 0) {
                const s_left = getPersonType(mask, col - 1);
                internal_happiness += adj_matrix[s][s_left];
            }
        }
        mask_info[mask] = {
            intro: current_intro_count,
            extro: current_extro_count,
            happiness: internal_happiness
        };
    }

    // DP memoization table
    // memo[row][prev_mask][introverts_left][extroverts_left]
    // Stores the maximum happiness from 'row' onwards, given the 'prev_mask'
    // and remaining 'introverts_left' and 'extroverts_left'.
    // Initialize with -1 to indicate uncomputed states.
    const memo = new Array(m).fill(0).map(() =>
        new Array(max_mask_val).fill(0).map(() =>
            new Array(introverts + 1).fill(0).map(() =>
                new Array(extroverts + 1).fill(-1)
            )
        )
    );

    // Recursive DP function
    // row: current row being processed (0 to m-1)
    // prev_mask: bitmask representing the state of the previous row (row - 1)
    // i_left: number of introverts remaining
    // e_left: number of extroverts remaining
    const solve = (row, prev_mask, i_left, e_left) => {
        // Base case: all rows processed, no more happiness to add
        if (row === m) {
            return 0;
        }
        // Memoization: return precomputed result if available
        if (memo[row][prev_mask][i_left][e_left] !== -1) {
            return memo[row][prev_mask][i_left][e_left];
        }

        let max_happiness = 0;

        // Iterate through all possible masks (configurations) for the current row
        for (let current_mask = 0; current_mask < max_mask_val; current_mask++) {
            const { intro: current_intro_count, extro: current_extro_count, happiness: internal_happiness } = mask_info[current_mask];

            // Check if we have enough people to place for the current_mask configuration
            if (i_left < current_intro_count || e_left < current_extro_count) {
                continue; // Cannot form this mask, skip
            }

            let vertical_happiness = 0;
            // Calculate happiness from vertical adjacencies between prev_mask and current_mask
            for (let col = 0; col < n; col++) {
                const s_top = getPersonType(prev_mask, col);
                const s = getPersonType(current_mask, col);
                vertical_happiness += adj_matrix[s][s_top];
            }

            // Recurse for the next row with updated remaining people counts
            const total_happiness = internal_happiness + vertical_happiness +
                                    solve(row + 1, current_mask, i_left - current_intro_count, e_left - current_extro_count);

            max_happiness = Math.max(max_happiness, total_happiness);
        }

        // Store and return the computed maximum happiness for this state
        return memo[row][prev_mask][i_left][e_left] = max_happiness;
    };

    // Start the DP from row 0.
    // The 'prev_mask' for the first row is considered 0 (an empty row above it).
    return solve(0, 0, introverts, extroverts);
};