var latestTimeCatchTheBus = function(buses, passengers, capacity) {
    buses.sort((a, b) => a - b);
    passengers.sort((a, b) => a - b);

    let result = 0;
    let passengerIndex = 0;

    for (let i = 0; i < buses.length; i++) {
        const busTime = buses[i];
        let currentCapacity = 0;
        let lastPassengerTime = 0;

        while (passengerIndex < passengers.length && passengers[passengerIndex] <= busTime && currentCapacity < capacity) {
            lastPassengerTime = passengers[passengerIndex];
            passengerIndex++;
            currentCapacity++;
        }

        if (currentCapacity < capacity) {
            result = Math.max(result, busTime);
        } else {
            result = Math.max(result, lastPassengerTime - 1);
        }
    }

    while (passengerIndex > 0 && passengers[passengerIndex - 1] === result) {
        result--;
        passengerIndex--;
    }

    return result;
};