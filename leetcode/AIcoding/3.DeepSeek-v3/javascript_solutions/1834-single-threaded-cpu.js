var getOrder = function(tasks) {
    const n = tasks.length;
    const indexedTasks = tasks.map((task, index) => [...task, index]);
    indexedTasks.sort((a, b) => a[0] - b[0] || a[2] - b[2]);

    const minHeap = new MinPriorityQueue({ priority: (task) => task[1] * 100000 + task[2] });
    let currentTime = 0;
    let taskIndex = 0;
    const result = [];

    while (result.length < n) {
        while (taskIndex < n && indexedTasks[taskIndex][0] <= currentTime) {
            minHeap.enqueue(indexedTasks[taskIndex]);
            taskIndex++;
        }

        if (minHeap.size() > 0) {
            const task = minHeap.dequeue().element;
            currentTime += task[1];
            result.push(task[2]);
        } else if (taskIndex < n) {
            currentTime = indexedTasks[taskIndex][0];
        }
    }

    return result;
};