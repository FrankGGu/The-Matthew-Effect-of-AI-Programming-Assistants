function averageWaitingTime(customers) {
    let totalWaitingTime = 0;
    let currentTime = 0;

    for (const [arrival, duration] of customers) {
        if (currentTime < arrival) {
            currentTime = arrival;
        }
        currentTime += duration;
        totalWaitingTime += currentTime - arrival;
    }

    return totalWaitingTime / customers.length;
}