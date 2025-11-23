var taskSchedulerII = function(tasks, space) {
    let lastSeen = new Map();
    let currentTime = 0;

    for (let i = 0; i < tasks.length; i++) {
        let task = tasks[i];
        if (lastSeen.has(task)) {
            let lastCompletionTime = lastSeen.get(task);
            let nextAvailableTimeForThisTask = lastCompletionTime + space + 1;
            currentTime = Math.max(currentTime + 1, nextAvailableTimeForThisTask);
        } else {
            currentTime = currentTime + 1;
        }
        lastSeen.set(task, currentTime);
    }

    return currentTime;
};