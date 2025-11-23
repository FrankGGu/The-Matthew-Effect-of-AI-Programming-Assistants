function averageWaitingTime(customers) {
    let totalWait = 0;
    let currentTime = 0;

    for (const [arrival, time] of customers) {
        if (currentTime < arrival) {
            currentTime = arrival;
        }
        currentTime += time;
        totalWait += currentTime - arrival;
    }

    return totalWait / customers.length;
}