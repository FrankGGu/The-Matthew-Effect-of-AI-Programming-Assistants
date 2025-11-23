var numberOfWeakCharacters = function(properties) {
    properties.sort((a, b) => a[0] - b[0] || b[1] - a[1]);
    let weakCharacters = 0;
    let maxDefense = 0;

    for (const [attack, defense] of properties) {
        if (defense < maxDefense) {
            weakCharacters++;
        } else {
            maxDefense = defense;
        }
    }

    return weakCharacters;
};