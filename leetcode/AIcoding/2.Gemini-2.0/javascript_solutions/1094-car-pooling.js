var carPooling = function(trips, capacity) {
    const stops = new Array(1001).fill(0);

    for (const trip of trips) {
        const [numPassengers, startLocation, endLocation] = trip;
        stops[startLocation] += numPassengers;
        stops[endLocation] -= numPassengers;
    }

    let currentPassengers = 0;
    for (let i = 0; i < 1001; i++) {
        currentPassengers += stops[i];
        if (currentPassengers > capacity) {
            return false;
        }
    }

    return true;
};