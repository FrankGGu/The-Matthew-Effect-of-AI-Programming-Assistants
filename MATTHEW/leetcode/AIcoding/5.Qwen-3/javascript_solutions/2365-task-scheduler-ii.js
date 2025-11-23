var leastInterval = function(tasks, n) {
    if (n === 0) return tasks.length;

    const count = {};
    let maxFreq = 0;
    let maxCount = 0;

    for (const task of tasks) {
        count[task] = (count[task] || 0) + 1;
        if (count[task] > maxFreq) {
            maxFreq = count[task];
            maxCount = 1;
        } else if (count[task] === maxFreq) {
            maxCount++;
        }
    }

    return Math.max((maxFreq - 1) * (n + 1) + maxCount, tasks.length);
};