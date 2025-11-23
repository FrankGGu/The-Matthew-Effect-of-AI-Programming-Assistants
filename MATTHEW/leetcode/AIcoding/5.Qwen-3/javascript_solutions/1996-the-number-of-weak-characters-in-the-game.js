var numberOfWeakCharacters = function(properties) {
    properties.sort((a, b) => a[0] === b[0] ? b[1] - a[1] : a[0] - b[0]);
    let count = 0;
    let maxDef = 0;
    for (const [atk, def] of properties) {
        if (def < maxDef) {
            count++;
        } else {
            maxDef = def;
        }
    }
    return count;
};