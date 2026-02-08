var numberOfWeakCharacters = function(properties) {
    properties.sort((a, b) => {
        if (a[0] !== b[0]) {
            return b[0] - a[0];
        } else {
            return a[1] - b[1];
        }
    });

    let weakCharacters = 0;
    let maxDefense = 0;

    for (let i = 0; i < properties.length; i++) {
        if (properties[i][1] < maxDefense) {
            weakCharacters++;
        }
        maxDefense = Math.max(maxDefense, properties[i][1]);
    }

    return weakCharacters;
};