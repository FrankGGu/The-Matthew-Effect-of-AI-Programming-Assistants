var tilingRectangle = function(n, m) {
    // Ensure n is always less than or equal to m to reduce state space by symmetry
    if (n > m) {
        [n, m] = [m, n];
    }

    // memoization map: key is a string representation of the heights array, value is min squares
    const memo = new Map();

    // solve(heights) attempts to tile the remaining uncovered area represented by 'heights'.
    // 'heights[j]' stores the current height of the covered portion in column 'j'.
    // The goal is to cover all columns up to height 'n'.
    // The function returns the minimum number of squares needed to cover the remaining area.
    function solve(heights) {
        const heightsKey = heights.join(',');
        if (memo.has(heightsKey)) {
            return memo.get(heightsKey);
        }

        // Find the minimum height in the current profile.
        // This 'minH' represents the lowest point in the current "skyline" of covered cells.
        let minH = n; // Initialize with max possible height (n)
        for (let j = 0; j < m; j++) {
            minH = Math.min(minH, heights[j]);
        }

        // If minH is equal to n, it means all columns are covered up to height n.
        // The entire rectangle is covered, so 0 additional squares are needed.
        if (minH === n) {
            return 0;
        }

        // Find the first column 'c' where the height is 'minH'.
        // The cell (minH, c) is the top-leftmost uncovered cell.
        let c = -1;
        for (let j = 0; j < m; j++) {
            if (heights[j] === minH) {
                c = j;
                break;
            }
        }

        let minSquares = Infinity;

        // Try placing squares of different sizes at (minH, c).
        // The maximum possible size 'k' for a square starting at (minH, c)
        // is limited by the remaining height (n - minH) and remaining width (m - c).
        // Also, the square cannot extend into columns that are already higher than minH.
        let maxK = Math.min(n - minH, m - c);

        // Iterate from largest possible square size down to 1.
        // Trying larger squares first can sometimes lead to pruning branches earlier
        // if a good solution is found quickly (though not strictly guaranteed for min-finding).
        for (let k = maxK; k >= 1; k--) {
            // Check if a k x k square can be placed at (minH, c).
            // This means all columns from 'c' to 'c + k - 1' must have their current height equal to 'minH'.
            let canPlace = true;
            for (let j = 0; j < k; j++) {
                if (c + j >= m || heights[c + j] !== minH) {
                    canPlace = false;
                    break;
                }
            }

            if (canPlace) {
                // Place the k x k square: update the heights for the affected columns.
                const newHeights = [...heights]; // Create a copy to avoid modifying the current state
                for (let j = 0; j < k; j++) {
                    newHeights[c + j] += k;
                }
                // Recursively solve for the remaining area and add 1 for the current square.
                minSquares = Math.min(minSquares, 1 + solve(newHeights));
            }
        }

        // Store the result in memoization table before returning.
        memo.set(heightsKey, minSquares);
        return minSquares;
    }

    // Initial state: all columns are covered up to height 0 (nothing covered yet).
    const initialHeights = new Array(m).fill(0);
    return solve(initialHeights);
};