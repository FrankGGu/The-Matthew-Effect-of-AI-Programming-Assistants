var assignTasks = function(servers, tasks) {
    const available = new MinPriorityQueue({
        priority: (server) => server.weight * 1e6 + server.index
    });
    const busy = new MinPriorityQueue({
        priority: (server) => server.freeTime
    });

    for (let i = 0; i < servers.length; i++) {
        available.enqueue({ weight: servers[i], index: i, freeTime: 0 });
    }

    const result = [];
    let currentTime = 0;

    for (let i = 0; i < tasks.length; i++) {
        currentTime = Math.max(currentTime, i);

        while (busy.size() > 0 && busy.front().priority <= currentTime) {
            const server = busy.dequeue().element;
            available.enqueue(server);
        }

        if (available.size() === 0) {
            const nextTime = busy.front().priority;
            currentTime = nextTime;

            while (busy.size() > 0 && busy.front().priority <= currentTime) {
                const server = busy.dequeue().element;
                available.enqueue(server);
            }
        }

        const server = available.dequeue().element;
        result.push(server.index);
        server.freeTime = currentTime + tasks[i];
        busy.enqueue(server);
    }

    return result;
};