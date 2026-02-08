var answerQueries = function(obstacles, queries) {
    // Sort the obstacles array in ascending order.
    // This allows for efficient querying using binary search.
    obstacles.sort((a, b) => a - b);

    const results = [];

    // For each query, find the count of obstacles that are less than or equal to the query value.
    for (const query of queries) {
        let left = 0;
        let right = obstacles.length - 1;
        let index = -1; // This will store the index of the last obstacle that is <= query

        // Perform binary search to find the "upper bound" for the query value.
        // The goal is to find the largest index `i` such that `obstacles[i] <= query`.
        while (left <= right) {
            let mid = Math.floor(left + (right - left) / 2);
            if (obstacles[mid] <= query) {
                index = mid; // This obstacle is valid, try to find a larger one to its right
                left = mid + 1;
            } else {
                right = mid - 1; // This obstacle is too large, search in the left half
            }
        }

        // If `index` is -1, it means no obstacle was found that is less than or equal to the query.
        // Otherwise, the count of such obstacles is `index + 1` (due to 0-based indexing).
        results.push(index === -1 ? 0 : index + 1);
    }

    return results;
};