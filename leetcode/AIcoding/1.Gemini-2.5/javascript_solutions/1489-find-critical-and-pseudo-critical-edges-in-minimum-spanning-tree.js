class DSU {
    constructor(n) {
        this.parent = Array(n).fill(0).map((_, i) => i);
        this.count = n; // Number of disjoint sets
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
            this.parent[rootI] = rootJ;
            this.count--;
            return true;
        }
        return false;
    }
}

function findCriticalAndPseudoCriticalEdges(n, edges) {
    // 1. Preprocess edges: add original index to each edge
    // Edge format: [u, v, weight, originalIndex]
    const processedEdges = edges.map((edge, i) => [...edge, i]);

    // Helper function to calculate MST weight using Kruskal's algorithm
    // n: number of nodes
    // allEdges: the full list of processed edges
    // excludeOriginalIndex: original index of an edge to exclude from consideration (-1 if none)
    // includeEdgeObject: the edge object [u, v, weight, originalIndex] to force-include (null if none)
    const calculateMST = (n, allEdges, excludeOriginalIndex, includeEdgeObject) => {
        const dsu = new DSU(n);
        let mstWeight = 0;

        // Force-include an edge if specified
        if (includeEdgeObject) {
            const [u, v, weight, originalIdx] = includeEdgeObject;
            // If the forced edge connects two previously disconnected components, include it.
            // For simple graphs (no self-loops, n >= 2), this union will always succeed initially.
            if (dsu.union(u, v)) {
                mstWeight += weight;
            } else {
                // If the forced edge connects nodes already in the same component (e.g., a self-loop or
                // if n=1), it still contributes its weight to the "forced" MST, but doesn't reduce dsu.count.
                // However, for valid MSTs, such edges would not be chosen.
                // Given typical LeetCode constraints (n >= 2, simple graphs), this branch is unlikely for the first union.
                // If it's a multi-edge scenario where u and v are already connected *before* other edges are considered,
                // this means the forced edge creates a cycle. Its weight is still added.
                mstWeight += weight;
            }
        }

        // Sort edges by weight for Kruskal's algorithm
        // Create a copy to avoid modifying the original array for subsequent calls
        const sortedEdges = [...allEdges].sort((a, b) => a[2] - b[2]);

        for (const [u, v, weight, originalIndex] of sortedEdges) {
            // Skip the excluded edge
            if (originalIndex === excludeOriginalIndex) {
                continue;
            }
            // Skip the force-included edge if it's already processed
            if (includeEdgeObject && originalIndex === includeEdgeObject[3]) {
                continue;
            }

            // If adding this edge connects two previously disconnected components
            if (dsu.union(u, v)) {
                mstWeight += weight;
            }
        }

        // If not all nodes are connected (i.e., dsu.count is greater than 1),
        // it means a spanning tree could not be formed.
        if (dsu.count > 1) {
            return Infinity; // Indicate that an MST is not possible or graph is disconnected
        }
        return mstWeight;
    };

    // 2. Calculate the original MST weight of the graph
    const originalMSTWeight = calculateMST(n, processedEdges, -1, null);

    const criticalEdges = [];
    const pseudoCriticalEdges = [];

    // 3. Iterate through each edge to determine if it's critical or pseudo-critical
    for (let i = 0; i < processedEdges.length; i++) {
        const currentEdge = processedEdges[i];
        const originalIndex = currentEdge[3];

        // Check if the current edge is critical:
        // Calculate MST weight without the current edge.
        // If the MST weight increases or becomes impossible (Infinity), the edge is critical.
        const mstWithoutCurrent = calculateMST(n, processedEdges, originalIndex, null);
        if (mstWithoutCurrent > originalMSTWeight) {
            criticalEdges.push(originalIndex);
            continue; // Critical edges cannot be pseudo-critical
        }

        // Check if the current edge is pseudo-critical (only if it's not critical):
        // Calculate MST weight by force-including the current edge.
        // If the resulting MST weight is equal to the original MST weight, the edge is pseudo-critical.
        const mstWithCurrentForced = calculateMST(n, processedEdges, -1, currentEdge);
        if (mstWithCurrentForced === originalMSTWeight) {
            pseudoCriticalEdges.push(originalIndex);
        }
    }

    return [criticalEdges, pseudoCriticalEdges];
}