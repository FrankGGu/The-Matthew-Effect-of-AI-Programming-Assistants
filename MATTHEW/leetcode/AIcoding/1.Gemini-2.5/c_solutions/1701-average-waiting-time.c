double averageWaitingTime(int** customers, int customersSize, int* customersColSize) {
    long long totalWaitingTime = 0;
    long long chefAvailableTime = 0; // Represents the time when the chef finishes the current order and becomes free

    for (int i = 0; i < customersSize; i++) {
        long long arrivalTime = customers[i][0];
        long long preparationTime = customers[i][1];

        // The chef can start cooking this order either when they become free
        // or when the customer arrives, whichever is later.
        long long actualCookStartTime;
        if (chefAvailableTime > arrivalTime) {
            actualCookStartTime = chefAvailableTime;
        } else {
            actualCookStartTime = arrivalTime;
        }

        // Calculate the time when this order will be finished
        long long finishTime = actualCookStartTime + preparationTime;

        // Calculate the waiting time for this customer
        // Waiting time = time order is finished - time customer arrived
        totalWaitingTime += (finishTime - arrivalTime);

        // Update the chef's availability time for the next customer
        chefAvailableTime = finishTime;
    }

    // Calculate the average waiting time
    return (double)totalWaitingTime / customersSize;
}