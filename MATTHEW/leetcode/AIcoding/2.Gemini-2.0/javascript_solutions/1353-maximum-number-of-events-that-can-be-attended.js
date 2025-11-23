var maxEvents = function(events) {
    events.sort((a, b) => a[1] - b[1]);
    const pq = [];
    let day = 1;
    let eventIndex = 0;
    let count = 0;

    while (eventIndex < events.length || pq.length > 0) {
        while (eventIndex < events.length && events[eventIndex][0] <= day) {
            pq.push(events[eventIndex][1]);
            eventIndex++;
        }

        pq.sort((a, b) => a - b);

        while (pq.length > 0 && pq[0] < day) {
            pq.shift();
        }

        if (pq.length > 0) {
            pq.shift();
            count++;
        }

        day++;
    }

    return count;
};