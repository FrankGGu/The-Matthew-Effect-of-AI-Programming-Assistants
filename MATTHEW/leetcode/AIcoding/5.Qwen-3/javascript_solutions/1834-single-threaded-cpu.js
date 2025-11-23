function leastInterval(tasks, n) {
    const map = {};
    for (const task of tasks) {
        map[task] = (map[task] || 0) + 1;
    }

    const counts = Object.values(map).sort((a, b) => b - a);
    const maxCount = counts[0];
    let maxCountNum = 1;

    for (let i = 1; i < counts.length; i++) {
        if (counts[i] === maxCount) {
            maxCountNum++;
        } else {
            break;
        }
    }

    return Math.max((maxCount - 1) * (n + 1) + maxCountNum, tasks.length);
}