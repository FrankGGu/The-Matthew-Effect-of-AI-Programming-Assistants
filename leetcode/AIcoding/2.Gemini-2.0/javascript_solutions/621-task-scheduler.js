var leastInterval = function(tasks, n) {
    const counts = new Array(26).fill(0);
    for (const task of tasks) {
        counts[task.charCodeAt(0) - 'A'.charCodeAt(0)]++;
    }
    counts.sort((a, b) => b - a);
    const maxCount = counts[0];
    let idleSlots = (maxCount - 1) * n;
    for (let i = 1; i < 26; i++) {
        idleSlots -= Math.min(maxCount - 1, counts[i]);
    }
    return idleSlots > 0 ? idleSlots + tasks.length : tasks.length;
};