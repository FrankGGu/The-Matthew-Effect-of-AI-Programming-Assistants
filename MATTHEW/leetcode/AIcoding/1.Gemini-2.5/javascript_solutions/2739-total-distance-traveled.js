var distanceTraveled = function(mainTank, additionalTank) {
    let totalDistance = 0;

    while (mainTank > 0) {
        if (mainTank >= 5 && additionalTank > 0) {
            mainTank -= 5;
            totalDistance += 50;
            mainTank += 1;
            additionalTank -= 1;
        } else {
            totalDistance += mainTank * 10;
            mainTank = 0;
        }
    }

    return totalDistance;
};