var alternatingGroups = function(colors, k) {
    const n = colors.length;
    let count = 0;
    let currentAlternatingPairs = 0;

    // Calculate alternating pairs for the first window (starting at index 0)
    // A group of length k requires k-1 alternating pairs.
    for (let j = 0; j < k - 1; j++) {
        // Check if colors[j] is different from colors[(j+1)%n]
        // For j < k-1, and k <= n, (j+1) will be less than n, so (j+1)%n is just j+1.
        if (colors[j] !== colors[j + 1]) {
            currentAlternatingPairs++;
        }
    }

    // Check if the first group (starting at index 0) is alternating
    if (currentAlternatingPairs === k - 1) {
        count++;
    }

    // Slide the window for the remaining starting positions (from 1 to n-1)
    for (let i = 1; i < n; i++) {
        // Remove the contribution of the pair leaving the window from the left
        // The pair leaving is (colors[(i-1)%n], colors[i%n])
        // Since i-1 and i are within [0, n-1], modulo is not strictly needed here for the array access itself,
        // but it conceptually represents the pair at the start of the previous window.
        if (colors[i - 1] !== colors[i]) {
            currentAlternatingPairs--;
        }

        // Add the contribution of the new pair entering the window from the right
        // The new pair entering is (colors[(i+k-2)%n], colors[(i+k-1)%n])
        // Modulo operator is crucial here because (i+k-2) and (i+k-1) can exceed n-1.
        if (colors[(i + k - 2) % n] !== colors[(i + k - 1) % n]) {
            currentAlternatingPairs++;
        }

        // Check if the current window is alternating
        if (currentAlternatingPairs === k - 1) {
            count++;
        }
    }

    return count;
};