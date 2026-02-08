var latestTimeCatchTheBus = function(buses, passengers, capacity) {
    buses.sort((a, b) => a - b);
    passengers.sort((a, b) => a - b);

    const passengerSet = new Set(passengers);

    let pIdx = 0;
    let candidateTime = 0;

    for (let i = 0; i < buses.length; i++) {
        const busTime = buses[i];
        let currentCapacity = capacity;
        let lastBoardedTime = -1;

        while (pIdx < passengers.length && passengers[pIdx] <= busTime && currentCapacity > 0) {
            lastBoardedTime = passengers[pIdx];
            pIdx++;
            currentCapacity--;
        }

        if (i === buses.length - 1) {
            if (currentCapacity > 0) {
                candidateTime = busTime;
                while (passengerSet.has(candidateTime)) {
                    candidateTime--;
                }
            } else {
                candidateTime = lastBoardedTime - 1;
                while (passengerSet.has(candidateTime)) {
                    candidateTime--;
                }
            }
        }
    }

    return candidateTime;
};