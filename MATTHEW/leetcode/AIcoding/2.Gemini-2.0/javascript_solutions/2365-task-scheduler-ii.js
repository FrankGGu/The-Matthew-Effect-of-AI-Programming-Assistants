var taskSchedulerII = function(tasks, space) {
    let day = 0;
    const completed = new Map();

    for (let task of tasks) {
        day++;
        if (completed.has(task) && day <= completed.get(task)) {
            day = completed.get(task);
            day++;
        }
        completed.set(task, day + space);
    }

    return day;
};