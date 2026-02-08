var avoidFlood = function(floors) {
    const n = floors.length;
    const result = new Array(n).fill(1);
    const lastRain = new Map();
    const dryDays = [];

    for (let i = 0; i < n; i++) {
        if (floors[i] === 0) {
            dryDays.push(i);
        } else {
            if (lastRain.has(floors[i])) {
                const lastIndex = lastRain.get(floors[i]);
                if (dryDays.length === 0 || dryDays[dryDays.length - 1] < lastIndex) {
                    return [];
                }
                const dryIndex = dryDays.pop();
                result[dryIndex] = floors[dryIndex];
            }
            lastRain.set(floors[i], i);
        }
    }

    for (let i = 0; i < n; i++) {
        if (floors[i] === 0) {
            result[i] = 1;
        } else if (result[i] === 1) {
            result[i] = 1;
        }
    }

    return result;
};