var countPoints = function(rings) {
    const rods = new Array(10).fill(0);
    for (let i = 0; i < rings.length; i += 2) {
        const color = rings[i];
        const rod = parseInt(rings[i + 1]);
        if (color === 'R') {
            rods[rod] |= 1;
        } else if (color === 'G') {
            rods[rod] |= 2;
        } else {
            rods[rod] |= 4;
        }
    }
    let count = 0;
    for (let i = 0; i < 10; i++) {
        if (rods[i] === 7) {
            count++;
        }
    }
    return count;
};