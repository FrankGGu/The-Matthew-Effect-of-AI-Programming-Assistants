function minimumTravelTime(operations) {
    let totalTime = 0;
    let mergeCount = 0;

    for (let i = 0; i < operations.length; i++) {
        totalTime += operations[i];
        if (operations[i] > 1) {
            mergeCount += operations[i] - 1;
        }
    }

    return totalTime + mergeCount;
}