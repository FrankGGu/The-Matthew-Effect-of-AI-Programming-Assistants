var countPoints = function(rings) {
    const rodMap = new Array(10).fill(0);

    for (let i = 0; i < rings.length; i += 2) {
        const color = rings[i];
        const rodIndex = rings[i + 1].charCodeAt(0) - '0'.charCodeAt(0);

        if (color === 'R') rodMap[rodIndex] |= 1;
        if (color === 'G') rodMap[rodIndex] |= 2;
        if (color === 'B') rodMap[rodIndex] |= 4;
    }

    return rodMap.filter(rod => rod === 7).length;
};