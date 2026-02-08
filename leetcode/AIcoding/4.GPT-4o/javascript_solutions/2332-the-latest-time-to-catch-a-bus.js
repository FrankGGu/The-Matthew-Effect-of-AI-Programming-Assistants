var latestTimeToCatchBus = function(buses, passengers, capacity) {
    buses.sort((a, b) => a - b);
    passengers.sort((a, b) => a - b);

    let busIndex = 0;
    let passengerIndex = 0;
    let lastBusTime = -1;

    while (busIndex < buses.length) {
        let currentBus = buses[busIndex];
        let count = 0;

        while (passengerIndex < passengers.length && passengers[passengerIndex] <= currentBus && count < capacity) {
            count++;
            passengerIndex++;
        }

        if (count < capacity) {
            lastBusTime = currentBus;
        } else {
            lastBusTime = passengers[passengerIndex - 1] - 1;
        }

        busIndex++;
    }

    while (lastBusTime > 0 && passengers.includes(lastBusTime)) {
        lastBusTime--;
    }

    return lastBusTime;
};