function getImportantPeople(people) {
    const map = new Map();
    for (const person of people) {
        const name = person[0];
        const time = person[1];
        if (!map.has(name)) {
            map.set(name, 0);
        }
        map.set(name, map.get(name) + time);
    }
    const total = Array.from(map.values()).reduce((a, b) => a + b, 0);
    const threshold = total / 2;

    const result = [];
    for (const [name, time] of map.entries()) {
        if (time > threshold) {
            result.push(name);
        }
    }
    return result;
}