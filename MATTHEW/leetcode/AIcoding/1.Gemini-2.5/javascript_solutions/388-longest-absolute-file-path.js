var lengthLongestPath = function(input) {
    if (!input) {
        return 0;
    }

    // pathLengths[i] stores the length of the path from the root up to and including
    // the directory/file at depth i-1.
    // pathLengths[0] conceptually represents the length before depth 0, which is 0.
    const pathLengths = [0]; 
    let maxLength = 0;

    const items = input.split('\n');

    for (const item of items) {
        let numTabs = 0;
        while (numTabs < item.length && item[numTabs] === '\t') {
            numTabs++;
        }

        const name = item.substring(numTabs);
        const currentDepth = numTabs;

        // Calculate the length of the current path
        // It's the length of the parent path (at currentDepth) + current item's name length.
        // Add 1 for the '/' separator if it's not the root level (currentDepth > 0).
        let currentPathLength = pathLengths[currentDepth] + name.length;
        if (currentDepth > 0) {
            currentPathLength += 1; // For the '/' separator
        }

        // Store this path length for the next level (currentDepth + 1)
        pathLengths[currentDepth + 1] = currentPathLength;

        // If the current item is a file (contains a '.'), check if it's the longest path found so far.
        if (name.includes('.')) {
            maxLength = Math.max(maxLength, currentPathLength);
        }
    }

    return maxLength;
};