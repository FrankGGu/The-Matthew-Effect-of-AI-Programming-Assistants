var minProcessingTime = function(processorTime, tasks) {
    processorTime.sort((a, b) => a - b);
    tasks.sort((a, b) => b - a);

    let maxOverallTime = 0;
    const tasksPerProcessor = 4;

    for (let i = 0; i < processorTime.length; i++) {
        let currentProcessorFinishTime = processorTime[i] + tasks[i * tasksPerProcessor];
        maxOverallTime = Math.max(maxOverallTime, currentProcessorFinishTime);
    }

    return maxOverallTime;
};