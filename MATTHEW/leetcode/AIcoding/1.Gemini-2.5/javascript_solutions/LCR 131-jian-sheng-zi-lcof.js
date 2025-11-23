var cutBamboo = function(heights) {
    if (heights.length === 0) {
        return 0;
    }

    const distinctHeights = new Set(heights);
    return distinctHeights.size - 1;
};