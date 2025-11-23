var distanceTraveled = function(mainTank, additionalTank) {
    let distance = 0;
    while (mainTank > 0) {
        if (mainTank >= 5) {
            distance += 5 * 10;
            mainTank -= 5;
            if (additionalTank > 0) {
                mainTank += 1;
                additionalTank -= 1;
            }
        } else {
            distance += mainTank * 10;
            mainTank = 0;
        }
    }
    return distance;
};