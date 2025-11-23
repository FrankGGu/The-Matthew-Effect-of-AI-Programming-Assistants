var busiestServers = function(k, arrival, load) {
    const n = arrival.length;
    const count = new Array(k).fill(0);
    const freeServers = [];
    const busyServers = new Set();
    let maxRequests = 0;

    for (let i = 0; i < n; i++) {
        while (busyServers.size > 0 && [...busyServers].some(server => arrival[i] >= server[1])) {
            const server = busyServers.values().next().value;
            busyServers.delete(server);
            freeServers.push(server[0]);
        }

        if (freeServers.length > 0) {
            const serverIndex = freeServers.shift();
            count[serverIndex]++;
            busyServers.add([serverIndex, arrival[i] + load[i]]);
            maxRequests = Math.max(maxRequests, count[serverIndex]);
        } else {
            const nextFreeServer = (i % k);
            const serverIndex = nextFreeServer;
            if (arrival[i] >= (busyServers.has(serverIndex) ? [...busyServers].find(s => s[0] === serverIndex)[1] : 0)) {
                count[serverIndex]++;
                busyServers.add([serverIndex, arrival[i] + load[i]]);
                maxRequests = Math.max(maxRequests, count[serverIndex]);
            }
        }
    }

    return count.reduce((result, c, index) => {
        if (c === maxRequests) result.push(index);
        return result;
    }, []);
};