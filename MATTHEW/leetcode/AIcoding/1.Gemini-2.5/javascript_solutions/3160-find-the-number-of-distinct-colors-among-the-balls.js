var distinctColors = function(colors, queries) {
    const colorCounts = new Map();
    let distinctCount = 0;

    // Initialize color counts and distinct count from initial colors
    for (const color of colors) {
        if (colorCounts.get(color) === undefined) {
            distinctCount++;
        }
        colorCounts.set(color, (colorCounts.get(color) || 0) + 1);
    }

    const results = [];

    // Process each query
    for (const [index, newColor] of queries) {
        const oldColor = colors[index];

        // Decrement count for the old color
        colorCounts.set(oldColor, colorCounts.get(oldColor) - 1);
        if (colorCounts.get(oldColor) === 0) {
            distinctCount--;
        }

        // Update the ball's color
        colors[index] = newColor;

        // Increment count for the new color
        if (colorCounts.get(newColor) === undefined || colorCounts.get(newColor) === 0) {
            distinctCount++;
        }
        colorCounts.set(newColor, (colorCounts.get(newColor) || 0) + 1);

        results.push(distinctCount);
    }

    return results;
};