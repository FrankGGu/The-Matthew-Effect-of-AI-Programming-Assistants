var maximumScore = function(scores, edges) {
    const n = scores.length;
    // adj[i] will store a list of [score_of_neighbor, neighbor_index] pairs,
    // sorted by score_of_neighbor in descending order, keeping at most 3 elements.
    const adj = Array(n).fill(0).map(() => []); 

    // Helper function to add a neighbor to a node's adjacency list
    // This function maintains the list sorted by score (desc) and capped at 3 elements.
    const addNeighbor = (node, neighbor_score, neighbor_index) => {
        const list = adj[node];

        let inserted = false;
        for (let i = 0; i < list.length; i++) {
            if (neighbor_score > list[i][0]) {
                list.splice(i, 0, [neighbor_score, neighbor_index]);
                inserted = true;
                break;
            }
        }
        // If not inserted yet, and the list is not full, append it.
        // This covers cases where the new neighbor has the smallest score or the list is empty.
        if (!inserted && list.length < 3) {
            list.push([neighbor_score, neighbor_index]);
            inserted = true;
        }

        // Ensure the list doesn't exceed 3 elements.
        // If a new element was inserted and the list size became 4, remove the smallest.
        if (list.length > 3) {
            list.pop(); 
        }
    };

    for (const [u, v] of edges) {
        addNeighbor(u, scores[v], v);
        addNeighbor(v, scores[u], u);
    }

    let maxScore = -1;

    // Iterate through each edge (b, c) as the middle segment of the path (a-b-c-d)
    for (const [b, c] of edges) {
        // Find potential 'a' nodes connected to 'b'
        for (const [score_a, node_a] of adj[b]) {
            // 'a' must be distinct from 'c'
            if (node_a === c) {
                continue;
            }

            // Find potential 'd' nodes connected to 'c'
            for (const [score_d, node_d] of adj[c]) {
                // 'd' must be distinct from 'b'
                if (node_d === b) {
                    continue;
                }
                // 'd' must be distinct from 'a'
                if (node_d === node_a) {
                    continue;
                }

                // If all four nodes (node_a, b, c, node_d) are distinct, calculate the score
                const currentScore = scores[node_a] + scores[b] + scores[c] + scores[node_d];
                maxScore = Math.max(maxScore, currentScore);
            }
        }
    }

    return maxScore;
};