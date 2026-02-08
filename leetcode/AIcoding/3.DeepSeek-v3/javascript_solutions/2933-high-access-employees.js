var highAccessEmployees = function(access_times) {
    const accessMap = new Map();

    for (const [name, timeStr] of access_times) {
        if (!accessMap.has(name)) {
            accessMap.set(name, []);
        }
        const hours = parseInt(timeStr.substring(0, 2));
        const minutes = parseInt(timeStr.substring(2));
        const totalMinutes = hours * 60 + minutes;
        accessMap.get(name).push(totalMinutes);
    }

    const result = [];

    for (const [name, times] of accessMap) {
        if (times.length < 3) continue;
        times.sort((a, b) => a - b);
        for (let i = 2; i < times.length; i++) {
            if (times[i] - times[i - 2] < 60) {
                result.push(name);
                break;
            }
        }
    }

    return result;
};