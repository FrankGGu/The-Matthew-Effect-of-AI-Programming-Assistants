var maxTasksAssigned = function(tasks, workers) {
    tasks.sort((a, b) => a - b);
    workers.sort((a, b) => a - b);

    let taskCount = 0;
    let i = 0, j = 0;

    while (i < tasks.length && j < workers.length) {
        if (tasks[i] <= workers[j]) {
            taskCount++;
            i++;
        }
        j++;
    }

    return taskCount;
};