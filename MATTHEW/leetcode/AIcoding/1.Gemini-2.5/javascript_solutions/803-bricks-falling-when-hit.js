class DSU {
    constructor(n) {
        this.parent = Array(n).fill(0).map((_, i) => i);
        this.size = Array(n).fill(1);
        this.topNodeIndex = n - 1; // The last index is designated as the virtual top node
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        return this.parent[i] = this.find(this.parent[i]);
    }

    union(i, j) {
        let rootI = this.find(i);
        let rootJ = this.find(j);

        if (rootI !== rootJ) {
            // Union by size: attach smaller tree under root of larger tree
            if (this.size[rootI] < this.size[rootJ]) {
                [rootI, rootJ] = [rootJ, rootI]; // Swap to ensure rootI is the larger or equal sized tree
            }
            this.parent[rootJ] = rootI;
            this.size[rootI] += this.size[rootJ];
            return true;
        }
        return false;
    }

    // Returns the number of bricks connected to the virtual top node
    getTopConnectedBricksCount() {
        // Subtract 1 because the virtual top node itself is included in its component's size
        return this.size[this.find(this.topNodeIndex)] - 1;
    }
}

var hitBricks = function(grid, hits) {
    const R = grid.length;
    const C = grid[0].length;
    const numCells = R * C;
    const virtualTopNodeIdx = numCells; // Index for the virtual top node

    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    // Create a copy of the grid to store its initial state
    const initialGrid = grid.map(row => [...row]);
    // This grid will be modified by removing bricks that are hit
    const currentGridState = grid.map(row => [...row]);

    // Mark bricks that will be hit as 0 in currentGridState
    // This is because we process hits in reverse, so these bricks are initially "missing"
    for (const [r, c] of hits) {
        if (currentGridState[r][c] === 1) { // Only mark if it was originally a brick
            currentGridState[r][c] = 0;
        }
    }

    // Initialize DSU with numCells + 1 (for the virtual top node)
    const dsu = new DSU(numCells + 1);

    // Helper to convert (r, c) coordinates to a 1D index
    const toIndex = (r, c) => r * C + c;

    // Build the initial DSU state from currentGridState (after removing all hit bricks)
    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C; c++) {
            if (currentGridState[r][c] === 1) {
                // If in the first row, connect to the virtual top node
                if (r === 0) {
                    dsu.union(toIndex(r, c), virtualTopNodeIdx);
                }
                // Connect to adjacent bricks (up and left are sufficient to connect components)
                for (const [dr, dc] of directions) {
                    const nr = r + dr;
                    const nc = c + dc;

                    if (nr >= 0 && nr < R && nc >= 0 && nc < C && currentGridState[nr][nc] === 1) {
                        dsu.union(toIndex(r, c), toIndex(nr, nc));
                    }
                }
            }
        }
    }

    const ans = Array(hits.length).fill(0);

    // Process hits in reverse order
    for (let i = hits.length - 1; i >= 0; i--) {
        const [r, c] = hits[i];

        // If the original grid at this position was 0, hitting it does nothing
        if (initialGrid[r][c] === 0) {
            ans[i] = 0;
            continue;
        }

        // Get the number of bricks connected to the top *before* adding this brick back
        const prevTopConnectedCount = dsu.getTopConnectedBricksCount();

        // Add the brick back to the grid state
        currentGridState[r][c] = 1;

        // Perform unions for the newly added brick
        // Connect to virtual top node if in the first row
        if (r === 0) {
            dsu.union(toIndex(r, c), virtualTopNodeIdx);
        }

        // Connect to existing neighbors (all 4 directions)
        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < R && nc >= 0 && nc < C && currentGridState[nr][nc] === 1) {
                dsu.union(toIndex(r, c), toIndex(nr, nc));
            }
        }

        // Get the number of bricks connected to the top *after* adding this brick back
        const currentTopConnectedCount = dsu.getTopConnectedBricksCount();

        // The number of bricks that fell is the increase in top-connected bricks, minus the brick itself
        // Math.max(0, ...) handles cases where the brick was already part of the top-connected component
        // or if adding it back didn't connect it to the top.
        ans[i] = Math.max(0, currentTopConnectedCount - prevTopConnectedCount - 1);
    }

    return ans;
};