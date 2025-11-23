function getOrder(tasks) {
    const indexedTasks = tasks.map((task, index) => [task[0], task[1], index]);
    indexedTasks.sort((a, b) => a[0] - b[0]);

    const result = [];
    const minHeap = [];
    let time = 0;
    let i = 0;

    while (i < indexedTasks.length || minHeap.length > 0) {
        while (i < indexedTasks.length && indexedTasks[i][0] <= time) {
            minHeap.push(indexedTasks[i]);
            minHeap.sort((a, b) => a[1] - b[1] || a[2] - b[2]);
            i++;
        }

        if (minHeap.length > 0) {
            const task = minHeap.shift();
            result.push(task[2]);
            time += task[1];
        } else if (i < indexedTasks.length) {
            time = indexedTasks[i][0];
        }
    }

    return result;
}