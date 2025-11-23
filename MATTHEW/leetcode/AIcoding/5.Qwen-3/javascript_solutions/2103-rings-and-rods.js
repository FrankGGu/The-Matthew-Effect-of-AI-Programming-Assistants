function countPoints(rings) {
    const colorMap = new Map();

    for (let i = 0; i < rings.length; i += 2) {
        const color = rings[i];
        const rod = rings[i + 1];

        if (!colorMap.has(rod)) {
            colorMap.set(rod, new Set());
        }

        colorMap.get(rod).add(color);
    }

    let count = 0;
    for (const colors of colorMap.values()) {
        if (colors.size === 3) {
            count++;
        }
    }

    return count;
}