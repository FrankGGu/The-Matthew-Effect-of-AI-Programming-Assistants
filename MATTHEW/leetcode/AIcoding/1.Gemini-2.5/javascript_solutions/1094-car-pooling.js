var carPooling = function(trips, capacity) {
    const maxLocation = 1000;
    const passengerChanges = new Array(maxLocation + 1).fill(0);

    for (const trip of trips) {
        const numPassengers = trip[0];
        const startLocation = trip[1];
        const endLocation = trip[2];

        passengerChanges[startLocation] += numPassengers;
        if (endLocation <= maxLocation) {
            passengerChanges[endLocation] -= numPassengers;
        }
    }

    let currentPassengers = 0;
    for (let i = 0; i <= maxLocation; i++) {
        currentPassengers += passengerChanges[i];
        if (currentPassengers > capacity) {
            return false;
        }
    }

    return true;
};