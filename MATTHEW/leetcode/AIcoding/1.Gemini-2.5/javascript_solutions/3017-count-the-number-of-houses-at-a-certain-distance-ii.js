var countOfPairs = function(n, x, y) {
    const ans = new Array(n).fill(0);

    // Ensure x is smaller than y for consistent calculations
    // This is not strictly necessary for correctness due to Math.abs,
    // but often helps in reasoning about paths.
    if (x > y) {
        [x, y] = [y, x];
    }

    // Iterate over all unique pairs (i, j) where i < j
    for (let i = 1; i <= n; i++) {
        for (let j = i + 1; j <= n; j++) {
            // Path 1: Direct path along the line graph
            const dist1 = j - i;

            // Path 2: Using the special edge (x, y) from x to y
            // This path goes from i to x, then x to y via special road, then y to j.
            const dist2 = Math.abs(i - x) + 1 + Math.abs(j - y);

            // Path 3: Using the special edge (x, y) from y to x
            // This path goes from i to y, then y to x via special road, then x to j.
            const dist3 = Math.abs(i - y) + 1 + Math.abs(j - x);

            // The shortest distance is the minimum of these three path options
            const shortestDist = Math.min(dist1, dist2, dist3);

            // Increment the count for this distance.
            // Distances are 1-indexed (e.g., distance 1, 2, ... n-1),
            // while the answer array is 0-indexed (ans[0] for dist 1, ans[1] for dist 2, etc.).
            ans[shortestDist - 1]++;
        }
    }

    return ans;
};