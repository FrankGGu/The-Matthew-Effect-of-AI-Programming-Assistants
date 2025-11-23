var maxAverageRatio = function(classes, extraStudents) {
    const maxHeap = new MaxPriorityQueue({
        priority: (cls) => {
            const [pass, total] = cls;
            return (pass + 1) / (total + 1) - pass / total;
        }
    });

    for (const cls of classes) {
        maxHeap.enqueue(cls);
    }

    while (extraStudents > 0) {
        const { element: [pass, total] } = maxHeap.dequeue();
        maxHeap.enqueue([pass + 1, total + 1]);
        extraStudents--;
    }

    let totalRatio = 0;
    while (!maxHeap.isEmpty()) {
        const { element: [pass, total] } = maxHeap.dequeue();
        totalRatio += pass / total;
    }

    return totalRatio / classes.length;
};