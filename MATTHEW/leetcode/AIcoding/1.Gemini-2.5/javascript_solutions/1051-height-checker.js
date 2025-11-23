var heightChecker = function(heights) {
    const expected = [...heights].sort((a, b) => a - b);
    let mismatches = 0;

    for (let i = 0; i < heights.length; i++) {
        if (heights[i] !== expected[i]) {
            mismatches++;
        }
    }

    return mismatches;
};