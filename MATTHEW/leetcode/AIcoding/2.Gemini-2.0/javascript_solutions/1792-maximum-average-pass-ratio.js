var maxAverageRatio = function(classes, extra_students) {
    const pq = new MaxPriorityQueue({ priority: x => x[0] });
    for (const [pass, total] of classes) {
        pq.enqueue([ (pass + 1) / (total + 1) - pass / total , pass, total]);
    }

    for (let i = 0; i < extra_students; i++) {
        const { element: [diff, pass, total] } = pq.dequeue();
        pq.enqueue([ (pass + 2) / (total + 2) - (pass + 1) / (total + 1), pass + 1, total + 1]);
    }

    let sum = 0;
    let count = 0;
    while (!pq.isEmpty()) {
        const { element: [diff, pass, total] } = pq.dequeue();
        sum += pass / total;
        count++;
    }

    return sum / classes.length;
};