var destCity = function(paths) {
    const sourceCities = new Set();
    for (const path of paths) {
        sourceCities.add(path[0]);
    }

    for (const path of paths) {
        const destination = path[1];
        if (!sourceCities.has(destination)) {
            return destination;
        }
    }
    return "";
};