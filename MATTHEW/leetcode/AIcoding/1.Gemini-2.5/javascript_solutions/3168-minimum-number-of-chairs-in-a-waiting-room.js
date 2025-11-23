var minimumChairs = function(times) {
    let events = [];
    for (let i = 0; i < times.length; i++) {
        events.push([times[i][0], 1]);
        events.push([times[i][1], -1]);
    }

    events.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return a[1] - b[1];
    });

    let currentChairs = 0;
    let maxChairs = 0;

    for (let i = 0; i < events.length; i++) {
        currentChairs += events[i][1];
        maxChairs = Math.max(maxChairs, currentChairs);
    }

    return maxChairs;
};