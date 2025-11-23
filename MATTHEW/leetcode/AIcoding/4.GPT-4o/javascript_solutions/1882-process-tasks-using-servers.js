var assignTasks = function(servers, tasks) {
    const n = servers.length;
    const available = new MinPriorityQueue({ priority: x => x[1] });
    const busy = new MinPriorityQueue({ priority: x => x[0] });
    const result = new Array(tasks.length).fill(0);
    const time = Array.from({ length: n }, () => 0);

    for (let i = 0; i < n; i++) {
        available.enqueue([i, time[i]]);
    }

    for (let t = 0; t < tasks.length; t++) {
        while (busy.size() > 0 && busy.front().element[0] <= t) {
            const [id, _] = busy.dequeue().element;
            available.enqueue([id, time[id]]);
        }

        if (available.size() > 0) {
            const [id, _] = available.dequeue().element;
            result[t] = id;
            busy.enqueue([t + tasks[t], id]);
            time[id] += tasks[t];
        } else {
            const [nextFreeTime, id] = busy.front().element;
            t = nextFreeTime - 1;
        }
    }

    return result;
};