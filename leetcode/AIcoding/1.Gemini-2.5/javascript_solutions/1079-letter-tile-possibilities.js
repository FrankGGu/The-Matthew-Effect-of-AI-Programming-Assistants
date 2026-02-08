var numTilePossibilities = function(tiles) {
    const freq = new Map();
    for (const char of tiles) {
        freq.set(char, (freq.get(char) || 0) + 1);
    }

    const result = new Set();

    function backtrack(currentPath) {
        if (currentPath.length > 0) {
            result.add(currentPath);
        }

        for (const char of Array.from(freq.keys()).sort()) { // Iterate through sorted keys for consistent order, though not strictly necessary for correctness
            if (freq.get(char) > 0) {
                freq.set(char, freq.get(char) - 1);
                backtrack(currentPath + char);
                freq.set(char, freq.get(char) + 1); // Backtrack
            }
        }
    }

    backtrack("");
    return result.size;
};