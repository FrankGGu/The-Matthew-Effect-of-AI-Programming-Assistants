var numClashingPairs = function(colors) {
    const n = colors.length;
    if (n < 2) {
        return 0;
    }

    let totalPairs = n * (n - 1) / 2;

    const freqMap = new Map();
    for (const color of colors) {
        freqMap.set(color, (freqMap.get(color) || 0) + 1);
    }

    let identicalPairs = 0;
    for (const count of freqMap.values()) {
        if (count >= 2) {
            identicalPairs += count * (count - 1) / 2;
        }
    }

    return totalPairs - identicalPairs;
};