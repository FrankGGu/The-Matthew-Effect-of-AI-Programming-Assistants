var carPooling = function(trips, capacity) {
    const changes = {};

    for (const [passengers, start, end] of trips) {
        changes[start] = (changes[start] || 0) + passengers;
        changes[end] = (changes[end] || 0) - passengers;
    }

    let currentPassengers = 0;

    for (const key in changes) {
        currentPassengers += changes[key];
        if (currentPassengers > capacity) {
            return false;
        }
    }

    return true;
};