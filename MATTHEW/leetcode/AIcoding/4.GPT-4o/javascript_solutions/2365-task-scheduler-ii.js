function leastInterval(tasks, n) {
    const taskCount = new Array(26).fill(0);
    for (const task of tasks) {
        taskCount[task.charCodeAt(0) - 'A'.charCodeAt(0)]++;
    }

    const maxCount = Math.max(...taskCount);
    const maxCountTasks = taskCount.filter(count => count === maxCount).length;

    return Math.max(tasks.length, (maxCount - 1) * (n + 1) + maxCountTasks);
}