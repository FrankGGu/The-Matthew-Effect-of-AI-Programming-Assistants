function alertNames(keyName, keyTime) {
    const record = {};
    for (let i = 0; i < keyName.length; i++) {
        if (!record[keyName[i]]) {
            record[keyName[i]] = [];
        }
        record[keyName[i]].push(keyTime[i]);
    }

    const alertSet = new Set();
    for (const [name, times] of Object.entries(record)) {
        times.sort();
        for (let i = 0; i < times.length; i++) {
            const [h, m] = times[i].split(':').map(Number);
            const currentTime = h * 60 + m;
            let count = 1;
            for (let j = i + 1; j < times.length; j++) {
                const [nh, nm] = times[j].split(':').map(Number);
                const nextTime = nh * 60 + nm;
                if (nextTime - currentTime < 60) {
                    count++;
                } else {
                    break;
                }
                if (count >= 3) {
                    alertSet.add(name);
                    break;
                }
            }
        }
    }
    return Array.from(alertSet).sort();
}