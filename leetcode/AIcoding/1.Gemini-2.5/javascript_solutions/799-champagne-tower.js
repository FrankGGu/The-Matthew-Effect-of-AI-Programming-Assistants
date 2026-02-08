var champagneTower = function(poured, query_row, query_glass) {
    // dp[r][c] will store the total amount of champagne that flows into glass (r, c).
    // The array needs to be large enough to hold values for rows up to query_row + 1,
    // because champagne from row 'r' overflows into row 'r+1'.
    // If query_row is 99, we need to calculate up to dp[99][c] and potentially fill dp[100][c].
    // So, we need (query_row + 1) rows, and each row 'r' has 'r+1' glasses.
    // A square matrix of size (query_row + 2) x (query_row + 2) is sufficient
    // to handle 0-indexed rows and columns up to query_row + 1.
    const dp = Array(query_row + 2).fill(0).map(() => Array(query_row + 2).fill(0));

    // Pour all the champagne into the top-most glass (0,0).
    dp[0][0] = poured;

    // Simulate the flow of champagne down the tower.
    // Iterate through rows from 0 up to query_row.
    // We only need to simulate up to query_row because the target glass is in query_row,
    // and its contents are determined by glasses in query_row-1.
    // However, to correctly calculate dp[query_row][query_glass], we need to propagate
    // champagne from dp[query_row-1] to dp[query_row].
    // The loop should go up to query_row to ensure dp[query_row][query_glass] is fully calculated.
    for (let r = 0; r <= query_row; r++) {
        // Iterate through glasses in the current row 'r'.
        // A row 'r' has 'r+1' glasses, indexed from c=0 to c=r.
        for (let c = 0; c <= r; c++) {
            // If the current glass has more than 1 unit of champagne, it overflows.
            if (dp[r][c] > 1) {
                const excess = dp[r][c] - 1;
                // Distribute the excess evenly to the two glasses directly below.
                // Each glass below receives half of the excess.
                dp[r + 1][c] += excess / 2;
                dp[r + 1][c + 1] += excess / 2;
            }
        }
    }

    // The amount of champagne in the target glass (query_row, query_glass)
    // is at most 1.0. If more flowed into it, it means the glass is full
    // and the rest has overflowed.
    return Math.min(1.0, dp[query_row][query_glass]);
};