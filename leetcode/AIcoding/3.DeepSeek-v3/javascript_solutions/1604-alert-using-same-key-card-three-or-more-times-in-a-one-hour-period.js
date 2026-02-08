var alertNames = function(keyName, keyTime) {
    const nameToTimes = {};
    const result = [];

    for (let i = 0; i < keyName.length; i++) {
        const name = keyName[i];
        const time = keyTime[i];
        if (!nameToTimes[name]) {
            nameToTimes[name] = [];
        }
        nameToTimes[name].push(time);
    }

    for (const name in nameToTimes) {
        const times = nameToTimes[name];
        times.sort();

        for (let i = 2; i < times.length; i++) {
            const prevTime = times[i - 2];
            const currentTime = times[i];

            if (getTimeDiff(prevTime, currentTime) <= 60) {
                result.push(name);
                break;
            }
        }
    }

    return result.sort();
};

function getTimeDiff(time1, time2) {
    const [h1, m1] = time1.split(':').map(Number);
    const [h2, m2] = time2.split(':').map(Number);

    const total1 = h1 * 60 + m1;
    const total2 = h2 * 60 + m2;

    return total2 - total1;
}