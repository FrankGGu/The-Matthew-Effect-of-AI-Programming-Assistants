var alertNames = function(keyName, keyTime) {
    const map = new Map();
    for (let i = 0; i < keyName.length; i++) {
        const name = keyName[i];
        const time = keyTime[i];
        if (!map.has(name)) {
            map.set(name, []);
        }
        map.get(name).push(time);
    }

    const alert = [];
    for (const [name, times] of map) {
        if (times.length < 3) {
            continue;
        }
        const sortedTimes = times.sort();
        for (let i = 0; i < sortedTimes.length - 2; i++) {
            const time1 = sortedTimes[i];
            const time2 = sortedTimes[i + 1];
            const time3 = sortedTimes[i + 2];

            const [h1, m1] = time1.split(':').map(Number);
            const [h2, m2] = time2.split(':').map(Number);
            const [h3, m3] = time3.split(':').map(Number);

            const totalMinutes1 = h1 * 60 + m1;
            const totalMinutes2 = h2 * 60 + m2;
            const totalMinutes3 = h3 * 60 + m3;

            if (totalMinutes3 - totalMinutes1 <= 60) {
                alert.push(name);
                break;
            }
        }
    }

    return [...new Set(alert)].sort();
};