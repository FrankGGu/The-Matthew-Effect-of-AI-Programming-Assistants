function findDelayedArrivalTime(arrivalTime, delayedTime) {
    return (arrivalTime + delayedTime) % 24;
}