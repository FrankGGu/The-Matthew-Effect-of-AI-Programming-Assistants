var maxDistance = function(colors) {
    const n = colors.length;
    let maxDist = 0;

    // Check distances from the first house (index 0)
    // Iterate from the rightmost house towards the left
    for (let j = n - 1; j > 0; j--) {
        if (colors[j] !== colors[0]) {
            maxDist = Math.max(maxDist, j); // Distance is j - 0
            break; // Found the furthest house with a different color from index 0
        }
    }

    // Check distances from the last house (index n-1)
    // Iterate from the leftmost house towards the right
    for (let i = 0; i < n - 1; i++) {
        if (colors[i] !== colors[n - 1]) {
            maxDist = Math.max(maxDist, (n - 1) - i); // Distance is (n-1) - i
            break; // Found the furthest house with a different color from index n-1
        }
    }

    return maxDist;
};