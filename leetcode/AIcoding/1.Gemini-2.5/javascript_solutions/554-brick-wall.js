var leastBricks = function(wall) {
    const gapFrequencies = new Map();
    let maxFrequency = 0;
    const totalRows = wall.length;

    for (let i = 0; i < totalRows; i++) {
        let currentWidth = 0;
        // Iterate up to wall[i].length - 1 because the last gap position
        // is the end of the wall and cannot be crossed.
        for (let j = 0; j < wall[i].length - 1; j++) {
            currentWidth += wall[i][j];
            gapFrequencies.set(currentWidth, (gapFrequencies.get(currentWidth) || 0) + 1);
            maxFrequency = Math.max(maxFrequency, gapFrequencies.get(currentWidth));
        }
    }

    return totalRows - maxFrequency;
};