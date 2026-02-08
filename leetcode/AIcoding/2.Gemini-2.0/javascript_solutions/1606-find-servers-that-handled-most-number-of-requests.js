var busiestServers = function(k, arrival, duration) {
    const available = Array.from({ length: k }, (_, i) => i);
    const busy = [];
    const counts = new Array(k).fill(0);

    for (let i = 0; i < arrival.length; i++) {
        while (busy.length > 0 && busy[0][0] <= arrival[i]) {
            available.push(busy.shift()[1]);
            available.sort((a, b) => a - b);
        }

        if (available.length > 0) {
            let serverIndex = available.findIndex(server => server >= i % k);
            if (serverIndex === -1) {
                serverIndex = 0;
            }
            const server = available[serverIndex];
            available.splice(serverIndex, 1);
            busy.push([arrival[i] + duration[i], server]);
            busy.sort((a, b) => a[0] - b[0]);
            counts[server]++;
        }
    }

    let maxCount = 0;
    for (let i = 0; i < k; i++) {
        maxCount = Math.max(maxCount, counts[i]);
    }

    const result = [];
    for (let i = 0; i < k; i++) {
        if (counts[i] === maxCount) {
            result.push(i);
        }
    }

    return result;
};