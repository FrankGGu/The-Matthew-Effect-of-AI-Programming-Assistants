var minGroups = function(intervals) {
    const events = [];
    for (const [start, end] of intervals) {
        events.push([start, 1]); // +1 for interval start
        events.push([end, -1]);  // -1 for interval end
    }

    // Sort events:
    // 1. Primary sort by time in ascending order.
    // 2. Secondary sort for events at the same time:
    //    Process start events (+1) before end events (-1).
    //    This ensures that if an interval ends at time T and another starts at time T,
    //    the starting interval is counted before the ending one,
    //    correctly reflecting that they overlap at T.
    events.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return b[1] - a[1]; // Sort by type descending: +1 comes before -1
    });

    let currentGroups = 0;
    let maxGroups = 0;

    for (const [time, type] of events) {
        currentGroups += type;
        maxGroups = Math.max(maxGroups, currentGroups);
    }

    return maxGroups;
};