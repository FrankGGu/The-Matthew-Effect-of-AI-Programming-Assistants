var busiestServers = function(k, arrival, load) {
    const available = new MinPriorityQueue({
        priority: (server) => server
    });
    for (let i = 0; i < k; i++) {
        available.enqueue(i);
    }

    const busy = new MinPriorityQueue({
        priority: (server) => server.endTime
    });

    const requestCount = new Array(k).fill(0);

    for (let i = 0; i < arrival.length; i++) {
        const startTime = arrival[i];
        const endTime = startTime + load[i];

        while (!busy.isEmpty() && busy.front().priority <= startTime) {
            const server = busy.dequeue().element;
            const adjustedServer = ((server - (i % k)) + k) % k + (i % k);
            available.enqueue(adjustedServer);
        }

        if (!available.isEmpty()) {
            const server = available.dequeue().element % k;
            requestCount[server]++;
            busy.enqueue({ endTime, element: server });
        }
    }

    const maxRequests = Math.max(...requestCount);
    const result = [];
    for (let i = 0; i < k; i++) {
        if (requestCount[i] === maxRequests) {
            result.push(i);
        }
    }
    return result;
};