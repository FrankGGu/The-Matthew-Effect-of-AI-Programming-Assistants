function maxTasks(tasks, workers, coins, power) {
    tasks.sort((a, b) => a - b);
    workers.sort((a, b) => a - b);

    let taskIdx = 0;
    let workerIdx = workers.length - 1;
    let result = 0;

    while (taskIdx < tasks.length && workerIdx >= 0) {
        if (tasks[taskIdx] <= workers[workerIdx] + coins) {
            result++;
            taskIdx++;
            workerIdx--;
        } else if (workers[workerIdx] >= power) {
            coins += workers[workerIdx] - power;
            workerIdx--;
        } else {
            break;
        }
    }

    return result;
}