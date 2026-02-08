var minimumSeconds = function(heights) {
    let n = heights.length;
    let totalSeconds = 0;

    for (let i = 0; i < n; i++) {
        let left = (i > 0) ? heights[i - 1] : 0;
        let right = (i < n - 1) ? heights[i + 1] : 0;
        totalSeconds += Math.max(0, heights[i] - Math.max(left, right));
    }

    return totalSeconds;
};