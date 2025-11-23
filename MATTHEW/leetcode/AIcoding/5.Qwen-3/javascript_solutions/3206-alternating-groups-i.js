function numberOfAlternatingGroups(colors) {
    const n = colors.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        const prev = colors[(i - 1 + n) % n];
        const curr = colors[i];
        const next = colors[(i + 1) % n];
        if (prev !== curr && curr !== next) {
            count++;
        }
    }
    return count;
}