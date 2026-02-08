function minimumTime(rooms) {
    const n = rooms.length;
    const dist = new Array(n).fill(Infinity);
    dist[0] = 0;
    const queue = [[0, 0]]; // [current room, time taken]

    while (queue.length > 0) {
        const [current, time] = queue.shift();

        for (const [next, timeToNext] of rooms[current]) {
            const newTime = time + timeToNext;
            if (newTime < dist[next]) {
                dist[next] = newTime;
                queue.push([next, newTime]);
            }
        }
    }

    return dist[n - 1] === Infinity ? -1 : dist[n - 1];
}