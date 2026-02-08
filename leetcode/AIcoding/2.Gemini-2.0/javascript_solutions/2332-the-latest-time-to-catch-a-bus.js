var latestTimeCatchTheBus = function(buses, passengers, capacity) {
    buses.sort((a, b) => a - b);
    passengers.sort((a, b) => a - b);
    let passengerIndex = 0;
    for (let bus of buses) {
        let count = 0;
        while (passengerIndex < passengers.length && passengers[passengerIndex] <= bus && count < capacity) {
            passengerIndex++;
            count++;
        }
    }

    if (passengerIndex === 0) {
        return buses[buses.length - 1];
    }

    if (passengerIndex === 0 || (passengerIndex > 0 && (passengerIndex === passengers.length || passengers[passengerIndex - 1] < buses[buses.length-1]))) {
        let ans = buses[buses.length - 1];
        while (passengers.includes(ans)) {
            ans--;
        }
        return ans;
    }

    let ans = passengers[passengerIndex] - 1;
    while (passengers.includes(ans)) {
        ans--;
    }
    return ans;

};