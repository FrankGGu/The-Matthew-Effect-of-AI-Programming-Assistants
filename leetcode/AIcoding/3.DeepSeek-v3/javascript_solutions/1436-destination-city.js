var destCity = function(paths) {
    const from = new Set();
    const to = new Set();

    for (const [a, b] of paths) {
        from.add(a);
        to.add(b);
    }

    for (const city of to) {
        if (!from.has(city)) {
            return city;
        }
    }

    return "";
};