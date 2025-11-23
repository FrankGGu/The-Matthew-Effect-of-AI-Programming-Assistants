var maxEvents = function(events) {
    events.sort((a, b) => a[0] - b[0]);
    let minHeap = new MinPriorityQueue();
    let day = 0, count = 0, index = 0;

    while (index < events.length || minHeap.size() > 0) {
        if (minHeap.size() === 0) {
            day = events[index][0];
        }

        while (index < events.length && events[index][0] <= day) {
            minHeap.enqueue(events[index][1]);
            index++;
        }

        minHeap.dequeue();
        count++;
        day++;

        while (minHeap.size() > 0 && minHeap.front().element < day) {
            minHeap.dequeue();
        }
    }

    return count;
};