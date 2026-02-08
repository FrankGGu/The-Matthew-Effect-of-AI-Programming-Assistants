var carPooling = function(trips, capacity) {
    const maxLocation = Math.max(...trips.map(trip => trip[2]));
    const locations = new Array(maxLocation + 1).fill(0);

    for (const [passengers, start, end] of trips) {
        locations[start] += passengers;
        locations[end] -= passengers;
    }

    let currentPassengers = 0;
    for (let i = 0; i < locations.length; i++) {
        currentPassengers += locations[i];
        if (currentPassengers > capacity) {
            return false;
        }
    }

    return true;
};