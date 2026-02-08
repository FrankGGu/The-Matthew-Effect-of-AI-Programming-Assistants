var minProcessingTime = function(processorTime, tasks) {
    processorTime.sort((a, b) => a - b);
    tasks.sort((a, b) => b - a);
    let maxTime = 0;
    const n = processorTime.length;
    for (let i = 0; i < n; i++) {
        const currentMax = processorTime[i] + tasks[i * 4];
        if (currentMax > maxTime) {
            maxTime = currentMax;
        }
    }
    return maxTime;
};