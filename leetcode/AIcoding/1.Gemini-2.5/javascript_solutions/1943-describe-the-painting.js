var describeThePainting = function(paintings) {
    const events = [];
    for (const [start, end, color] of paintings) {
        events.push([start, 0, BigInt(color)]); // 0 for start event (add color)
        events.push([end, 1, BigInt(color)]);   // 1 for end event (remove color)
    }

    if (events.length === 0) {
        return [];
    }

    // Sort events:
    // 1. By x-coordinate (event[0]) in ascending order.
    // 2. If x-coordinates are equal, start events (type 0) come before end events (type 1).
    events.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return a[1] - b[1];
    });

    const result = [];
    let currentSum = 0n; // Use BigInt for sum to handle large color values
    let lastX = events[0][0]; // Initialize lastX with the first event's x-coordinate

    for (const event of events) {
        const x = event[0];
        const type = event[1];
        const color = event[2];

        // If there's a segment between lastX and current x, and currentSum is not zero,
        // add it to the result. This segment uses the currentSum *before* processing
        // the event at 'x'.
        if (x > lastX && currentSum > 0n) {
            result.push([lastX, x, Number(currentSum)]); // Convert BigInt back to Number for output
        }

        // Update currentSum based on the current event
        if (type === 0) { // Start event
            currentSum += color;
        } else { // End event
            currentSum -= color;
        }

        // Update lastX to the current event's x-coordinate for the next iteration
        lastX = x;
    }

    return result;
};