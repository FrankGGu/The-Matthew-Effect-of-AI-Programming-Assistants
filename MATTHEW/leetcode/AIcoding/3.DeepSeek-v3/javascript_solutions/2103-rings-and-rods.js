var countPoints = function(rings) {
    const rods = new Array(10).fill().map(() => new Set());
    for (let i = 0; i < rings.length; i += 2) {
        const color = rings[i];
        const rod = rings[i + 1];
        rods[rod].add(color);
    }
    let count = 0;
    for (const rod of rods) {
        if (rod.size === 3) {
            count++;
        }
    }
    return count;
};