function highestPeaks(heights) {
    const n = heights.length;
    const result = Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        if (heights[i] > 0) {
            result[i] = heights[i];
        }
    }

    for (let i = 1; i < n; i++) {
        if (result[i] > 0) {
            result[i] = Math.max(result[i], result[i - 1] - 1);
        }
    }

    for (let i = n - 2; i >= 0; i--) {
        if (result[i] > 0) {
            result[i] = Math.max(result[i], result[i + 1] - 1);
        }
    }

    return result;
}