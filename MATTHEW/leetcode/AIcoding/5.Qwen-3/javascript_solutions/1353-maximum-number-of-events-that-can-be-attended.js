function maxEvents(events) {
    events.sort((a, b) => a[1] - b[1]);
    let count = 0;
    let last = -1;
    for (let [start, end] of events) {
        if (start <= end && start > last) {
            count++;
            last = end;
        }
    }
    return count;
}