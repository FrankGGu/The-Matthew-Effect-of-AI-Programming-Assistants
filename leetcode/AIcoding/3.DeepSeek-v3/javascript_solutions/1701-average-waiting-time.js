var averageWaitingTime = function(customers) {
    let totalWaitingTime = 0;
    let currentTime = 0;

    for (let i = 0; i < customers.length; i++) {
        const [arrival, time] = customers[i];
        if (currentTime < arrival) {
            currentTime = arrival;
        }
        currentTime += time;
        totalWaitingTime += currentTime - arrival;
    }

    return totalWaitingTime / customers.length;
};