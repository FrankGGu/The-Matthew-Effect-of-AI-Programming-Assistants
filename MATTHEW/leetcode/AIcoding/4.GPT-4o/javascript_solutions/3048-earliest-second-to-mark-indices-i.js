function earliestFullMark(seconds) {
    const n = seconds.length;
    const lastSeen = new Map();
    let earliest = Infinity;

    for (let i = 0; i < n; i++) {
        if (lastSeen.has(seconds[i])) {
            earliest = Math.min(earliest, lastSeen.get(seconds[i]));
        }
        lastSeen.set(seconds[i], i);
    }

    return earliest === Infinity ? -1 : earliest;
}