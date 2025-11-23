function minTaskTime(tasks, timeLimit) {
    tasks.sort((a, b) => a - b);
    let totalTime = 0;
    let currentBatch = 0;

    for (let i = 0; i < tasks.length; i++) {
        if (currentBatch + tasks[i] <= timeLimit) {
            currentBatch += tasks[i];
        } else {
            totalTime += timeLimit;
            currentBatch = tasks[i];
        }
    }
    totalTime += currentBatch;

    return totalTime;
}