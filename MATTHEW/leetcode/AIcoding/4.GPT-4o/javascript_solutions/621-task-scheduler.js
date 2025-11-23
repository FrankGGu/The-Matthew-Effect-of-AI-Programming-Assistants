var leastInterval = function(tasks, n) {
    const count = new Array(26).fill(0);
    for (const task of tasks) {
        count[task.charCodeAt(0) - 'A'.charCodeAt(0)]++;
    }

    const maxCount = Math.max(...count);
    const maxCountTasks = count.filter(c => c === maxCount).length;

    return Math.max(tasks.length, (maxCount - 1) * (n + 1) + maxCountTasks);
};