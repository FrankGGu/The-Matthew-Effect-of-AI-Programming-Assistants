var assignTasks = function(servers, tasks) {
    const n = servers.length;
    const m = tasks.length;
    const result = new Array(m);

    const available = new MinPriorityQueue({ priority: x => x[0] });
    const busy = new MinPriorityQueue({ priority: x => x[0] });

    for (let i = 0; i < n; i++) {
        available.enqueue([servers[i], i]);
    }

    let time = 0;
    for (let i = 0; i < m; i++) {
        time = Math.max(time, i);

        while (!busy.isEmpty() && busy.front().priority <= time) {
            const [finishTime, weight, index] = busy.dequeue().element;
            available.enqueue([weight, index]);
        }

        if (available.isEmpty()) {
            time = busy.front().priority;
            while (!busy.isEmpty() && busy.front().priority <= time) {
                const [finishTime, weight, index] = busy.dequeue().element;
                available.enqueue([weight, index]);
            }
        }

        const [weight, index] = available.dequeue().element;
        result[i] = index;
        busy.enqueue([time + tasks[i], weight, index]);
    }

    return result;
};