function alertNames(keyName, keyTime) {
    const map = new Map();
    for (let i = 0; i < keyName.length; i++) {
        const name = keyName[i];
        const time = keyTime[i];
        if (!map.has(name)) {
            map.set(name, []);
        }
        map.get(name).push(time);
    }

    const result = [];
    for (const [name, times] of map.entries()) {
        times.sort((a, b) => a - b);
        for (let i = 2; i < times.length; i++) {
            if (times[i] - times[i - 2] <= 60) {
                result.push(name);
                break;
            }
        }
    }

    return result;
}