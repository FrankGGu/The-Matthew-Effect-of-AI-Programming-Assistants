var adventureCamp = function(expeditionLog) {
    const start = expeditionLog[0].split("->");
    const allLocations = new Set(start);

    for (let i = 1; i < expeditionLog.length; i++) {
        const locations = expeditionLog[i].split("->");
        for (const location of locations) {
            allLocations.add(location);
        }
    }

    let maxNewLocations = 0;
    for (let i = 1; i < expeditionLog.length; i++) {
        const prevLocations = expeditionLog[i - 1].split("->");
        const currLocations = expeditionLog[i].split("->");

        let newLocationsCount = 0;
        for (const location of currLocations) {
            if (!prevLocations.includes(location)) {
                newLocationsCount++;
            }
        }
        maxNewLocations = Math.max(maxNewLocations, newLocationsCount);
    }

    return maxNewLocations;
};