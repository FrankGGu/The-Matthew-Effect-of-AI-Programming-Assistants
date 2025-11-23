var countHighestScoreNodes = function(parents) {
    const n = parents.length;
    const children = Array.from({ length: n }, () => []);

    // Build the adjacency list for children
    for (let i = 1; i < n; i++) {
        children[parents[i]].push(i);
    }

    let maxScore = 0n; // Use BigInt for score as it can exceed Number.MAX_SAFE_INTEGER
    let countMaxScore = 0;

    // DFS function to calculate subtree size and update max score
    // It returns the size of the subtree rooted at 'node'
    const dfs = (node) => {
        let currentScore = 1n; // Initialize score for the current node
        let subtreeSize = 1; // Start with 1 for the current node itself

        // Iterate over children to get their subtree sizes and update current node's score
        for (const child of children[node]) {
            const childSubtreeSize = dfs(child); // Recursively get child's subtree size
            currentScore *= BigInt(childSubtreeSize); // Multiply current node's score by child's subtree size
            subtreeSize += childSubtreeSize; // Add child's subtree size to current node's subtree size
        }

        // Calculate the size of the component containing the parent
        // This is the total number of nodes N minus the size of the current node's subtree
        const parentComponentSize = n - subtreeSize;
        if (parentComponentSize > 0) {
            currentScore *= BigInt(parentComponentSize); // Multiply if there's a parent component
        }

        // Update global maxScore and countMaxScore
        if (currentScore > maxScore) {
            maxScore = currentScore;
            countMaxScore = 1;
        } else if (currentScore === maxScore) {
            countMaxScore++;
        }

        return subtreeSize; // Return the size of the subtree rooted at 'node'
    };

    // Start DFS from the root (node 0)
    dfs(0);

    return countMaxScore;
};