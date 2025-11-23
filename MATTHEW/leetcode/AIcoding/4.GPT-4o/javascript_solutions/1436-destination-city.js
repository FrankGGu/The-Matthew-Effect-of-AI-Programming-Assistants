var destCity = function(paths) {
    const startCities = new Set();
    for (const [from, to] of paths) {
        startCities.add(from);
    }
    for (const [from, to] of paths) {
        if (!startCities.has(to)) {
            return to;
        }
    }
};