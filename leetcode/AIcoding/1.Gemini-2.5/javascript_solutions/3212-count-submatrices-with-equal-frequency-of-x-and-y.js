class FenwickTree {
    constructor(size) {
        this.tree = new Array(size + 1).fill(0); // 1-based indexing for tree array
        this.size = size; // Max index + 1 for 0-based, or max value for 1-based
    }

    // Add delta to element at 0-based index `idx`
    update(idx, delta) {
        idx++; // Convert to 1-based
        while (idx <= this.size) {
            this.tree[idx] += delta;
            idx += idx & (-idx);
        }
    }

    // Get sum of elements from 0 to 0-based index `idx`
    query(idx) {
        idx++; // Convert to 1-based
        let sum = 0;
        while (idx > 0) {
            sum += this.tree[idx];
            idx -= idx & (-idx);
        }
        return sum;
    }
}

var countSubmatrices = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let ans = 0;

    // Iterate over all possible top rows (r1)
    for (let r1 = 0; r1 < m; r1++) {
        // These arrays store sums for the current column slice (r1 to r2)
        const colDiffSums = new Array(n).fill(0); // Sum of (X-Y) for column j, rows r1 to r2
        const colXCounts = new Array(n).fill(0);  // Count of X for column j, rows r1 to r2
        const colYCounts = new Array(n).fill(0);  // Count of Y for column j, rows r1 to r2

        // Iterate over all possible bottom rows (r2) for the current r1
        for (let r2 = r1; r2 < m; r2++) {
            // Update column sums for row r2
            for (let j = 0; j < n; j++) {
                if (grid[r2][j] === 'X') {
                    colDiffSums[j]++;
                    colXCounts[j]++;
                } else if (grid[r2][j] === 'Y') {
                    colDiffSums[j]--;
                    colYCounts[j]++;
                }
            }

            // Now, for the fixed rows r1 to r2, we have 1D arrays
            // colDiffSums, colXCounts, colYCounts.
            // We need to find sub-arrays (c1 to c2) such that:
            // 1. sum(colDiffSums[j] for j in c1..c2) === 0
            // 2. sum(colXCounts[j] for j in c1..c2) > 0
            // 3. sum(colYCounts[j] for j in c1..c2) > 0

            // Calculate prefix sums for these 1D arrays
            // pDiff[k] stores sum of colDiffSums from index 0 to k-1
            const pDiff = new Array(n + 1).fill(0);
            const pX = new Array(n + 1).fill(0);
            const pY = new Array(n + 1).fill(0);

            for (let k = 0; k < n; k++) {
                pDiff[k + 1] = pDiff[k] + colDiffSums[k];
                pX[k + 1] = pX[k] + colXCounts[k];
                pY[k + 1] = pY[k] + colYCounts[k];
            }

            // Coordinate compression for pY values
            const uniquePYValues = new Set();
            for (let k = 0; k <= n; k++) {
                uniquePYValues.add(pY[k]);
            }
            const sortedUniquePY = Array.from(uniquePYValues).sort((a, b) => a - b);
            const pyToIdx = new Map();
            for (let i = 0; i < sortedUniquePY.length; i++) {
                pyToIdx.set(sortedUniquePY[i], i); // 0-based compressed index
            }
            const compressedPYSize = sortedUniquePY.length;

            // Group points by pDiff value. Each point is {pX_val, pY_val}.
            // These points represent (P_X[k], P_Y[k]) for a given P_diff[k].
            const diffGroups = new Map();
            for (let k = 0; k <= n; k++) {
                if (!diffGroups.has(pDiff[k])) {
                    diffGroups.set(pDiff[k], []);
                }
                diffGroups.get(pDiff[k]).push({ pX_val: pX[k], pY_val: pY[k] });
            }

            // Process each group using a sweep-line algorithm with Fenwick tree
            for (const [diffVal, points] of diffGroups) {
                // Events: {pX_val, type, pY_val}
                // type 0: add (represents a potential c1 prefix sum)
                // type 1: query (represents a potential c2+1 prefix sum)
                const events = [];
                for (const point of points) {
                    events.push({ pX_val: point.pX_val, type: 0, pY_val: point.pY_val }); // Add event
                    events.push({ pX_val: point.pX_val, type: 1, pY_val: point.pY_val }); // Query event
                }

                // Sort events:
                // 1. Primary: pX_val (ascending)
                // 2. Secondary: type (1 (query) before 0 (add) for same pX_val)
                //    This ensures queries for pX_val are processed before points with that pX_val are added.
                //    This correctly implements the condition P_X[c1] < P_X[c2+1].
                // 3. Tertiary: pY_val (ascending) - for tie-breaking
                events.sort((a, b) => {
                    if (a.pX_val !== b.pX_val) {
                        return a.pX_val - b.pX_val;
                    }
                    if (a.type !== b.type) {
                        return b.type - a.type; // type 1 before type 0
                    }
                    return a.pY_val - b.pY_val;
                });

                const ft = new FenwickTree(compressedPYSize);

                for (const event of events) {
                    const compressedPY = pyToIdx.get(event.pY_val);
                    if (event.type === 1) { // Query
                        // We need P_Y[c1] < P_Y[c2+1]. So query Fenwick tree for sum of counts
                        // for all compressed_P_Y values strictly less than current compressedPY.
                        ans += ft.query(compressedPY - 1);
                    } else { // Add
                        // Add the current point's P_Y value to the Fenwick tree.
                        ft.update(compressedPY, 1);
                    }
                }
            }
        }
    }

    return ans;
};