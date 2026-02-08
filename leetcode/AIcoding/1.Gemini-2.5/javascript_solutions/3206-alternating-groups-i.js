var numberOfAlternatingGroups = function(colors) {
    const n = colors.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        const color1 = colors[i];
        const color2 = colors[(i + 1) % n];
        const color3 = colors[(i + 2) % n];

        if (color1 !== color2 && color2 !== color3) {
            count++;
        }
    }

    return count;
};