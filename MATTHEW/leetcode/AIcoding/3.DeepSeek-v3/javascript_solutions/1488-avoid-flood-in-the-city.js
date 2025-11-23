var avoidFlood = function(rains) {
    const lakeToDays = new Map();
    const dryDays = [];
    const result = new Array(rains.length).fill(-1);

    for (let i = 0; i < rains.length; i++) {
        const lake = rains[i];
        if (lake === 0) {
            dryDays.push(i);
            result[i] = 1;
        } else {
            if (lakeToDays.has(lake)) {
                const lastRainDay = lakeToDays.get(lake);
                let found = false;
                for (let j = 0; j < dryDays.length; j++) {
                    if (dryDays[j] > lastRainDay) {
                        result[dryDays[j]] = lake;
                        dryDays.splice(j, 1);
                        found = true;
                        break;
                    }
                }
                if (!found) return [];
            }
            lakeToDays.set(lake, i);
        }
    }
    return result;
};