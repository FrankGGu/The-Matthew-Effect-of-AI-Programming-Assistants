var taskSchedulerII = function(tasks, space) {
    const lastDay = new Map();
    let currentDay = 0;

    for (const task of tasks) {
        currentDay++;
        if (lastDay.has(task)) {
            const last = lastDay.get(task);
            if (currentDay - last <= space) {
                currentDay = last + space + 1;
            }
        }
        lastDay.set(task, currentDay);
    }

    return currentDay;
};