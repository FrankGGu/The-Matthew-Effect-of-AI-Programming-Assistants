function restoreArray(adjacentPairs) {
    const graph = new Map();

    // Build the adjacency list
    for (const [u, v] of adjacentPairs) {
        if (!graph.has(u)) {
            graph.set(u, []);
        }
        if (!graph.has(v)) {
            graph.set(v, []);
        }
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    // Find one of the end points of the array
    // An end point will have only one neighbor
    let start = -1;
    for (const [num, neighbors] of graph.entries()) {
        if (neighbors.length === 1) {
            start = num;
            break;
        }
    }

    const n = adjacentPairs.length + 1;
    const result = new Array(n);
    result[0] = start;

    let prev = start;
    // The first element's only neighbor is the second element in the array
    let current = graph.get(start)[0]; 

    // Traverse the array
    for (let i = 1; i < n; i++) {
        result[i] = current;
        const neighbors = graph.get(current);

        let next;
        // If current is not an end point, it will have two neighbors: prev and next
        // We need to find the one that is not prev
        if (neighbors.length === 2) {
            if (neighbors[0] === prev) {
                next = neighbors[1];
            } else {
                next = neighbors[0];
            }
        } else { // current is the other end point, it has only one neighbor which must be prev
            // No next element to find, we've reached the end of the array
            // The loop will terminate after this iteration
            next = undefined; 
        }

        prev = current;
        current = next;
    }

    return result;
}