var sequenceReconstruction = function(org, seqs) {
    const n = org.length;

    // Handle empty org array
    if (n === 0) {
        // If org is empty, seqs must also effectively be empty
        // i.e., contain only empty sequences or no sequences at all.
        for (const seq of seqs) {
            if (seq.length > 0) {
                return false;
            }
        }
        return true;
    }

    const adj = new Map(); // node -> Set<neighbors>
    const inDegree = new Map(); // node -> count of incoming edges
    const nodesInSeqs = new Set(); // all unique numbers encountered in seqs

    // Initialize in-degrees for all potential nodes (numbers from 1 to n)
    // and track all nodes present in seqs.
    for (const seq of seqs) {
        for (const num of seq) {
            // Numbers in seqs must be within the range [1, n]
            if (num < 1 || num > n) {
                return false;
            }
            nodesInSeqs.add(num);
            inDegree.set(num, inDegree.get(num) || 0); // Ensure node is in map
        }
    }

    // Build the graph (adjacency list) and populate in-degrees
    for (const seq of seqs) {
        for (let i = 0; i < seq.length - 1; i++) {
            const u = seq[i];
            const v = seq[i+1];

            if (!adj.has(u)) {
                adj.set(u, new Set());
            }
            // Only add edge if it's new to avoid duplicate in-degree increments
            if (!adj.get(u).has(v)) {
                adj.get(u).add(v);
                inDegree.set(v, inDegree.get(v) + 1);
            }
        }
    }

    // Pre-check: All numbers in org must be present in seqs.
    // Also, the count of unique numbers in seqs must match n.
    // If nodesInSeqs.size < n, some elements of org are missing.
    // If nodesInSeqs.size > n, it implies numbers outside [1, n] which was already checked.
    if (nodesInSeqs.size !== n) {
        return false;
    }
    for (const num of org) {
        if (!nodesInSeqs.has(num)) {
            return false;
        }
    }

    // Perform topological sort (Kahn's algorithm)
    const queue = [];
    for (const node of nodesInSeqs) {
        if (inDegree.get(node) === 0) {
            queue.push(node);
        }
    }

    const reconstructedSeq = [];
    while (queue.length > 0) {
        // If there's more than one node with an in-degree of 0,
        // it means the sequence is not unique.
        if (queue.length > 1) {
            return false;
        }

        const u = queue.shift();
        reconstructedSeq.push(u);

        if (adj.has(u)) {
            for (const v of adj.get(u)) {
                inDegree.set(v, inDegree.get(v) - 1);
                if (inDegree.get(v) === 0) {
                    queue.push(v);
                }
            }
        }
    }

    // Final validation:
    // 1. The length of the reconstructed sequence must match n.
    //    (This handles cycles or disconnected components where not all nodes are processed).
    // 2. The reconstructed sequence must be identical to org.
    if (reconstructedSeq.length !== n) {
        return false;
    }

    for (let i = 0; i < n; i++) {
        if (reconstructedSeq[i] !== org[i]) {
            return false;
        }
    }

    return true;
};