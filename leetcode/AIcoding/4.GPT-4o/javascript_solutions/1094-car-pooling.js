var carPooling = function(trips, capacity) {
    let timeline = [];

    for (let [numPassengers, start, end] of trips) {
        timeline.push([start, numPassengers]);
        timeline.push([end, -numPassengers]);
    }

    timeline.sort((a, b) => a[0] - b[0]);

    let currentPassengers = 0;

    for (let [location, passengers] of timeline) {
        currentPassengers += passengers;
        if (currentPassengers > capacity) {
            return false;
        }
    }

    return true;
};