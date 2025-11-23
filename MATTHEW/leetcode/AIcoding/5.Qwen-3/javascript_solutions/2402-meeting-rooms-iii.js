function minMeetingRooms(intervals) {
    const startTimes = [];
    const endTimes = [];

    for (const [start, end] of intervals) {
        startTimes.push(start);
        endTimes.push(end);
    }

    startTimes.sort((a, b) => a - b);
    endTimes.sort((a, b) => a - b);

    let rooms = 0;
    let endPtr = 0;

    for (let i = 0; i < startTimes.length; i++) {
        if (startTimes[i] < endTimes[endPtr]) {
            rooms++;
        } else {
            endPtr++;
        }
    }

    return rooms;
}