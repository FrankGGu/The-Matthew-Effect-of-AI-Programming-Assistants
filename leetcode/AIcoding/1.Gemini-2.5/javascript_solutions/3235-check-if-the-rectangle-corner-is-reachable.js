class DSU {
    constructor(n) {
        this.parent = new Array(n);
        for (let i = 0; i < n; i++) {
            this.parent[i] = i;
        }
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        this.parent[i] = this.find(this.parent[i]);
        return this.parent[i];
    }

    union(i, j) {
        const rootI = this.find(i);
        const rootJ = this.find(j);
        if (rootI !== rootJ) {
            this.parent[rootI] = rootJ;
            return true;
        }
        return false;
    }
}

function canReach(width, height, circles) {
    const n = circles.length;
    // DSU nodes:
    // 0 to n-1: represent the circles
    // n: represents the left boundary (x=0)
    // n+1: represents the right boundary (x=width)
    // n+2: represents the bottom boundary (y=0)
    // n+3: represents the top boundary (y=height)
    const dsu = new DSU(n + 4);

    const distSq = (c1, c2) => {
        const dx = c1[0] - c2[0];
        const dy = c1[1] - c2[1];
        return dx * dx + dy * dy;
    };

    // Connect circles to each other if they touch or overlap
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const rSum = circles[i][2] + circles[j][2];
            if (distSq(circles[i], circles[j]) <= rSum * rSum) {
                dsu.union(i, j);
            }
        }
    }

    // Connect circles to the rectangle boundaries if they touch or overlap
    for (let i = 0; i < n; i++) {
        const [cx, cy, r] = circles[i];

        // Check connection to left boundary (x=0)
        if (cx - r <= 0) {
            dsu.union(i, n); 
        }
        // Check connection to right boundary (x=width)
        if (cx + r >= width) {
            dsu.union(i, n + 1); 
        }
        // Check connection to bottom boundary (y=0)
        if (cy - r <= 0) {
            dsu.union(i, n + 2); 
        }
        // Check connection to top boundary (y=height)
        if (cy + r >= height) {
            dsu.union(i, n + 3); 
        }
    }

    // A path from (0,0) to (width, height) is blocked if:
    // 1. The left boundary is connected to the right boundary (horizontally blocked)
    // 2. The bottom boundary is connected to the top boundary (vertically blocked)
    // If either of these conditions is true, the corner is NOT reachable.

    const leftBoundaryRoot = dsu.find(n);
    const rightBoundaryRoot = dsu.find(n + 1);
    const bottomBoundaryRoot = dsu.find(n + 2);
    const topBoundaryRoot = dsu.find(n + 3);

    if (leftBoundaryRoot === rightBoundaryRoot || bottomBoundaryRoot === topBoundaryRoot) {
        return false; // The corner is not reachable
    }

    return true; // The corner is reachable
}