function minProcessingTime(processorTime, tasks) {
    processorTime.sort((a, b) => a - b);
    tasks.sort((a, b) => b - a);

    let max = 0;
    for (let i = 0; i < processorTime.length; i++) {
        let startTime = processorTime[i];
        let endTime = startTime + tasks[i * 4];
        if (endTime > max) {
            max = endTime;
        }
    }
    return max;
}