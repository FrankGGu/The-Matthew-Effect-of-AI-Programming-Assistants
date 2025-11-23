function latestTimeCatchBus(buses, passengers, capacity) {
    buses.sort((a, b) => a - b);
    passengers.sort((a, b) => a - b);

    let i = 0;
    let j = 0;
    let lastPassenger = -1;

    while (i < buses.length) {
        let busTime = buses[i];
        let count = 0;

        while (j < passengers.length && passengers[j] <= busTime && count < capacity) {
            lastPassenger = passengers[j];
            j++;
            count++;
        }

        if (count < capacity) {
            return busTime;
        }

        i++;
    }

    let time = lastPassenger;
    while (time >= 0) {
        let found = false;
        for (let p of passengers) {
            if (p === time) {
                found = true;
                break;
            }
        }
        if (!found) {
            return time;
        }
        time--;
    }

    return 0;
}