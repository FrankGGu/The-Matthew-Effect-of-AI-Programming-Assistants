var findDynasty = function(dynasties, artifacts) {
    const map = new Map();
    for (const dynasty of dynasties) {
        const [name, start, end] = dynasty.split(',');
        map.set(name, [parseInt(start), parseInt(end)]);
    }

    const result = [];
    for (const artifact of artifacts) {
        const year = parseInt(artifact);
        let found = false;
        for (const [name, range] of map) {
            if (year >= range[0] && year <= range[1]) {
                result.push(name);
                found = true;
                break;
            }
        }
        if (!found) {
            result.push("Unknown");
        }
    }

    return result;
};