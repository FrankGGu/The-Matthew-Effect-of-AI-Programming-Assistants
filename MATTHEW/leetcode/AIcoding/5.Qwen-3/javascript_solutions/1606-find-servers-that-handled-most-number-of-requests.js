function findHotServers(requests, k) {
    const n = requests.length;
    const count = new Array(k).fill(0);
    const available = new Set([...Array(k).keys()]);
    const heap = [];

    for (let i = 0; i < n; i++) {
        const [time, server] = [requests[i], i];
        while (heap.length > 0 && heap[0][0] <= time) {
            const [_, s] = heap.shift();
            available.add(s);
        }

        if (available.size === 0) continue;

        const serverId = Math.min(...available);
        count[serverId]++;
        available.delete(serverId);
        heap.push([time + requests[i], serverId]);
    }

    const maxCount = Math.max(...count);
    const result = [];
    for (let i = 0; i < k; i++) {
        if (count[i] === maxCount) {
            result.push(i);
        }
    }
    return result;
}