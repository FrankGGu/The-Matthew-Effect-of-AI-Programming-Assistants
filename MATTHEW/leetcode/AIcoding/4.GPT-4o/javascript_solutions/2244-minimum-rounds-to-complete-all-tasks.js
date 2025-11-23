function minRounds(tasks) {
    const taskCount = {};
    for (const task of tasks) {
        taskCount[task] = (taskCount[task] || 0) + 1;
    }

    let rounds = 0;
    for (const count of Object.values(taskCount)) {
        if (count === 1) return -1;
        rounds += Math.ceil(count / 3);
    }

    return rounds;
}