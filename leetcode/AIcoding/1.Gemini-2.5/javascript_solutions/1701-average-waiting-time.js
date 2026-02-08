var averageWaitingTime = function(customers) {
    let totalWaitingTime = 0;
    let currentTime = 0;

    for (let i = 0; i < customers.length; i++) {
        const arrivalTime = customers[i][0];
        const prepTime = customers[i][1];

        const startTime = Math.max(arrivalTime, currentTime);
        const finishTime = startTime + prepTime;

        totalWaitingTime += (finishTime - arrivalTime);
        currentTime = finishTime;
    }

    return totalWaitingTime / customers.length;
};