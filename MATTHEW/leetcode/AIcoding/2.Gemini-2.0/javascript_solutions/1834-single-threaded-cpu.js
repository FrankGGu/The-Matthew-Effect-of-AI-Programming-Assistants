var getOrder = function(tasks) {
    const n = tasks.length;
    const indexedTasks = tasks.map((task, index) => [task[0], task[1], index]);
    indexedTasks.sort((a, b) => a[0] - b[0]);

    const pq = [];
    const result = [];
    let currentTime = 0;
    let taskIndex = 0;

    while (result.length < n) {
        while (taskIndex < n && indexedTasks[taskIndex][0] <= currentTime) {
            pq.push(indexedTasks[taskIndex]);
            taskIndex++;
        }

        if (pq.length === 0) {
            if (taskIndex < n) {
                currentTime = indexedTasks[taskIndex][0];
                while (taskIndex < n && indexedTasks[taskIndex][0] <= currentTime) {
                    pq.push(indexedTasks[taskIndex]);
                    taskIndex++;
                }
            } else {
                break;
            }
        }

        pq.sort((a, b) => a[1] - b[1] || a[2] - b[2]);

        const currentTask = pq.shift();
        currentTime += currentTask[1];
        result.push(currentTask[2]);
    }

    return result;
};