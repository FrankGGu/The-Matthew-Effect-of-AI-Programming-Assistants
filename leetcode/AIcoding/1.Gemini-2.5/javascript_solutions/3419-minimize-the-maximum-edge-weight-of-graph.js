class DSU {
    constructor(n) {
        // parent[i] stores the parent of element i.
        // Initially, each element is its own parent.
        this.parent = Array(n + 1).fill(0).map((_, i) => i);
        // numComponents tracks the number of distinct connected components.
        // Initially, there are 'n' components (each node is separate).
        this.numComponents = n;
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        return this.parent[i] = this.find(this.parent[i]); // Path compression
    }

    union(i, j) {
        let rootI = this.find(i);
        let rootJ = this.find(j);

        if (rootI !== rootJ) {
            this.parent[rootI] = rootJ; // Merge rootI's set into rootJ's set
            this.numComponents--; // Number of components decreases by one
            return true; // A merge successfully occurred
        }
        return false; // Elements were already in the same component
    }
}

function check(n, k, edges, maxAllowedWeight) {
    const dsu = new DSU(n);
    let changesNeeded = 0; // Counts how many edges with weight > maxAllowedWeight we had to use

    // Phase 1: Process "cheap" edges (weight <= maxAllowedWeight).
    // These edges can be used without consuming any of our 'k' budget.
    // They help connect components as much as possible for "free".
    for (const [u, v, w] of edges) {
        if (w <= maxAllowedWeight) {
            dsu.union(u, v);
        }
    }

    // Phase 2: Process "expensive" edges (weight > maxAllowedWeight).
    // If we need to use these edges to connect remaining components,
    // we must "pay" for them by consuming one of our 'k' allowances.
    for (const [u, v, w] of edges) {
        if (w > maxAllowedWeight) {
            // If uniting u and v merges two previously separate components,
            // it means we are using this "expensive" edge to establish connectivity.
            if (dsu.union(u, v)) {
                changesNeeded++;
            }
        }
    }

    // The condition is met if:
    // 1. All nodes are connected (i.e., there is only one component left).
    // 2. The number of "paid" changes does not exceed our budget 'k'.
    return dsu.numComponents === 1 && changesNeeded <= k;
}

var minMaxEdgeWeight = function(n, edges, k) {
    // The possible range for the maximum edge weight.
    // The minimum possible maximum weight is 0.
    // The maximum possible maximum weight is typically 10^9 or the largest weight in the input.
    // Using 1_000_000_000 as a safe upper bound for edge weights.
    let low = 0;
    let high = 1_000_000_000;
    let ans = high; // Initialize answer to a value that is definitely achievable or higher than any possible answer

    // Perform binary search on the possible range of the maximum edge weight.
    while (low <= high) {
        let mid = Math.floor(low + (high - low) / 2);

        // If it's possible to connect the graph with 'mid' as the maximum allowed weight
        // (and within 'k' changes), then 'mid' is a potential answer.
        // We try to find an even smaller maximum weight.
        if (check(n, k, edges, mid)) {
            ans = mid;
            high = mid - 1;
        } else {
            // If it's not possible with 'mid' as the maximum allowed weight,
            // we need to allow for a larger maximum weight.
            low = mid + 1;
        }
    }

    return ans;
};