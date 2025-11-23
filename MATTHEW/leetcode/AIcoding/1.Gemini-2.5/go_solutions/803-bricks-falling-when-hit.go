package main

func hitBricks(grid [][]int, hits [][]int) []int {
    R := len(grid)
    C := len(grid[0])
    numNodes := R*C + 1 // R*C for cells, last one for virtual top

    // Create a copy of the grid to modify
    currentGrid := make([][]int, R)
    for i := range currentGrid {
        currentGrid[i] = make([]int, C)
        copy(currentGrid[i], grid[i])
    }

    // Mark hit bricks as removed in currentGrid
    // Also, store original state of hit cells to know if we hit a brick or empty space
    originalHitBricks := make([]bool, len(hits))
    for k, hit := range hits {
        r, c := hit[0], hit[1]
        if currentGrid[r][c] == 1 {
            currentGrid[r][c] = 0 // Temporarily remove the brick
            originalHitBricks[k] = true
        } else {
            originalHitBricks[k] = false // Hitting an empty space
        }
    }

    dsu := newDSU(numNodes)
    virtualTopIdx := numNodes - 1

    // Initialize DSU sizes for existing bricks (after all hits are removed)
    for r := 0; r < R; r++ {
        for c := 0; c < C; c++ {
            if currentGrid[r][c] == 1 {
                dsu.sz[cellToIdx(r, c, C)] = 1 // Each brick initially has size 1
            }
        }
    }

    // Build initial DSU components based on currentGrid
    // (grid with all hit bricks removed)
    dr := []int{-1, 1, 0, 0}
    dc := []int{0, 0, -1, 1}

    for r := 0; r < R; r++ {
        for c := 0; c < C; c++ {
            if currentGrid[r][c] == 1 {
                idx := cellToIdx(r, c, C)
                // Connect to virtual top if in row 0
                if r == 0 {
                    dsu.union(idx, virtualTopIdx)
                }
                // Connect to neighbors
                for i := 0; i < 4; i++ {
                    nr, nc := r+dr[i], c+dc[i]
                    if nr >= 0 && nr < R && nc >= 0 && nc < C && currentGrid[nr][nc] == 1 {
                        dsu.union(idx, cellToIdx(nr, nc, C))
                    }
                }
            }
        }
    }

    // Process hits in reverse order
    ans := make([]int, len(hits))
    for k := len(hits) - 1; k >= 0; k-- {
        r, c := hits[k][0], hits[k][1]

        if !originalHitBricks[k] {
            ans[k] = 0 // Was already an empty space, no bricks fall
            continue
        }

        // Get size of component connected to top *before* adding this brick
        prevTopConnectedSize := dsu.sz[dsu.find(virtualTopIdx)]

        // Add the brick back
        currentGrid[r][c] = 1
        idx := cellToIdx(r, c, C)
        dsu.sz[idx] = 1 // Restore its size to 1

        // Connect the newly added brick to its neighbors and virtual top
        if r == 0 {
            dsu.union(idx, virtualTopIdx)
        }
        for i := 0; i < 4; i++ {
            nr, nc := r+dr[i], c+dc[i]
            if nr >= 0 && nr < R && nc >= 0 && nc < C && currentGrid[nr][nc] == 1 {
                dsu.union(idx, cellToIdx(nr, nc, C))
            }
        }

        // Get size of component connected to top *after* adding this brick
        newTopConnectedSize := dsu.sz[dsu.find(virtualTopIdx)]

        // The number of bricks that fell when this brick was removed is
        // the difference in top-connected size, minus the brick itself.
        // Use max(0, ...) to handle cases where no new bricks connect.
        ans[k] = max(0, newTopConnectedSize - prevTopConnectedSize - 1)
    }

    return ans
}

type DSU struct {
    parent []int
    sz     []int // Stores the number of bricks in the component rooted at this index
    virtualTop int
}

func newDSU(numNodes int) *DSU {
    parent := make([]int, numNodes)
    sz := make([]int, numNodes)
    for i := 0; i < numNodes; i++ {
        parent[i] = i
        sz[i] = 0 // Initialize size to 0, will update for bricks
    }
    return &DSU{
        parent: parent,
        sz: sz,
        virtualTop: numNodes - 1, // Last index is the virtual top
    }
}

func (d *DSU) find(i int) int {
    if d.parent[i] == i {
        return i
    }
    d.parent[i] = d.find(d.parent[i])
    return d.parent[i]
}

func (d *DSU) union(i, j int) {
    rootI := d.find(i)
    rootJ := d.find(j)

    if rootI == rootJ {
        return
    }

    // Ensure virtualTop is always the root if involved
    // If rootJ is the virtual top, swap them so rootI becomes the virtual top's root.
    if rootJ == d.virtualTop {
        rootI, rootJ = rootJ, rootI
    }

    // Now, if virtualTop is involved, it must be rootI.
    // So, if rootI == d.virtualTop, then it absorbs rootJ.
    if rootI == d.virtualTop {
        d.parent[rootJ] = rootI
        d.sz[rootI] += d.sz[rootJ]
    } else { // rootI is not virtualTop. Since we swapped, rootJ is also not virtualTop.
             // This is the case where neither component is connected to the virtual top yet.
        // Standard union by size
        if d.sz[rootI] < d.sz[rootJ] {
            rootI, rootJ = rootJ, rootI
        }
        d.parent[rootJ] = rootI
        d.sz[rootI] += d.sz[rootJ]
    }
}

func cellToIdx(r, c, C int) int {
    return r*C + c
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}