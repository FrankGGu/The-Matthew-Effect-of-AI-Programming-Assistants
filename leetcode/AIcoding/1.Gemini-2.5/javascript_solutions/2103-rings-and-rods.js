var countPoints = function(rings) {
    const rods = new Array(10).fill(0); // Use a bitmask for each rod
    // R: 1 (001)
    // G: 2 (010)
    // B: 4 (100)

    for (let i = 0; i < rings.length; i += 2) {
        const color = rings[i];
        const rodIndex = parseInt(rings[i + 1]);

        if (color === 'R') {
            rods[rodIndex] |= 1;
        } else if (color === 'G') {
            rods[rodIndex] |= 2;
        } else { // color === 'B'
            rods[rodIndex] |= 4;
        }
    }

    let completeRods = 0;
    const targetMask = 7; // 1 | 2 | 4 (001 | 010 | 100 = 111)

    for (let i = 0; i < 10; i++) {
        if (rods[i] === targetMask) {
            completeRods++;
        }
    }

    return completeRods;
};