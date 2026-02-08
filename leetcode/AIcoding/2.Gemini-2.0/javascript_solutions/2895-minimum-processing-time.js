var minProcessingTime = function(processorTime, tasks) {
    processorTime.sort((a, b) => a - b);
    tasks.sort((a, b) => b - a);

    let maxTime = 0;
    for (let i = 0; i < processorTime.length; i++) {
        maxTime = Math.max(maxTime, processorTime[i] + tasks[i * 4]);
    }

    return maxTime;
};