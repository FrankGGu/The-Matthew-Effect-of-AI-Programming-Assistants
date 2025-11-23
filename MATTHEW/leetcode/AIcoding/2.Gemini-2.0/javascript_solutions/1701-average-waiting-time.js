var averageWaitingTime = function(customers) {
    let currentTime = 0;
    let totalWaitingTime = 0;
    for (let i = 0; i < customers.length; i++) {
        const arrivalTime = customers[i][0];
        const serviceTime = customers[i][1];

        if (currentTime <= arrivalTime) {
            currentTime = arrivalTime + serviceTime;
            totalWaitingTime += serviceTime;
        } else {
            currentTime += serviceTime;
            totalWaitingTime += (currentTime - arrivalTime);
        }
    }
    return totalWaitingTime / customers.length;
};