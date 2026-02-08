function earliestFullMarkTime(marks, n) {
    const lastSeen = new Map();
    let earliestSecond = -1;

    for (let i = 0; i < marks.length; i++) {
        lastSeen.set(marks[i], i);
        if (lastSeen.size === n) {
            earliestSecond = Math.max(earliestSecond, Math.min(...lastSeen.values()));
        }
    }

    return earliestSecond === -1 ? -1 : earliestSecond + 1;
}