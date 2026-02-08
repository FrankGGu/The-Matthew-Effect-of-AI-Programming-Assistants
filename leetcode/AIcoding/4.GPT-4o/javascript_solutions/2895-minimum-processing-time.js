function minimumProcessingTime(tasks) {
    tasks.sort((a, b) => a - b);
    let totalTime = 0;
    let currentTime = 0;

    for (let task of tasks) {
        currentTime += task;
        totalTime += currentTime;
    }

    return totalTime;
}