var mostBooked = function(n, meetings) {
    meetings.sort((a, b) => a[0] - b[0]);
    const endTimes = new MinPriorityQueue();
    const count = new Array(n).fill(0);
    let time = 0;

    for (const [start, end] of meetings) {
        time = Math.max(time, start);
        while (endTimes.size() > 0 && endTimes.front().element <= time) {
            endTimes.dequeue();
        }
        for (let i = 0; i < n && endTimes.size() < n; i++) {
            if (!count[i]) {
                endTimes.enqueue({ element: start + (end - start), index: i });
                count[i]++;
                break;
            }
        }
        if (endTimes.size() === n) {
            const { element, index } = endTimes.dequeue();
            time = Math.max(time, element);
            count[index]++;
            endTimes.enqueue({ element: time + (end - start), index });
        }
    }

    let maxCount = -1, res = -1;
    for (let i = 0; i < n; i++) {
        if (count[i] > maxCount) {
            maxCount = count[i];
            res = i;
        }
    }
    return res;
};