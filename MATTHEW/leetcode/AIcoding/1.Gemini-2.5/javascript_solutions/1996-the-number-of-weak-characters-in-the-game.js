var numberOfWeakCharacters = function(properties) {
    // Sort characters:
    // Primary sort by attack in ascending order.
    // Secondary sort by defense in descending order for characters with the same attack.
    // This ensures that for characters with the same attack, the one with higher defense
    // appears earlier in the sorted array. When iterating from right to left,
    // a character with lower defense (but same attack) will be processed before
    // a character with higher defense (and same attack).
    properties.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0]; // Sort by attack ascending
        }
        return b[1] - a[1]; // Sort by defense descending for same attack
    });

    let weakCharacters = 0;
    let maxDefense = 0; // Tracks the maximum defense encountered so far from the right

    // Iterate from right to left (from the end of the sorted array to the beginning)
    for (let i = properties.length - 1; i >= 0; i--) {
        const [attack, defense] = properties[i];

        // If the current character's defense is less than the maximum defense
        // encountered so far, it means there exists a character to its right
        // (which has an attack value greater than or equal to the current character's attack)
        // that also has a strictly greater defense.
        // Due to the sorting strategy (attack ascending, defense descending for ties),
        // if maxDefense was set by a character with the same attack, that character
        // would have a defense greater than or equal to the current character's defense.
        // The descending defense sort ensures that if maxDefense was set by [A, D_stronger]
        // where A is the same as current attack, then D_stronger must be processed *after*
        // the current character [A, D_current] when iterating right-to-left.
        // Therefore, if defense < maxDefense, it implies that maxDefense must have been
        // set by a character with a strictly greater attack.
        if (defense < maxDefense) {
            weakCharacters++;
        } else {
            // Update maxDefense to be the maximum of current maxDefense and the current character's defense.
            maxDefense = Math.max(maxDefense, defense);
        }
    }

    return weakCharacters;
};