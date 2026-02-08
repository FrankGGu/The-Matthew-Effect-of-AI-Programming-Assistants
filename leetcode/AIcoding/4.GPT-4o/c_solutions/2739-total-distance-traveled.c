int distanceTraveled(int mainTank, int additionalTank) {
    int totalDistance = 0;
    int usableFuel = mainTank > 0 ? mainTank : 0;
    int maxDistance = usableFuel / 5 * 5;

    totalDistance += maxDistance;
    usableFuel -= maxDistance;

    if (usableFuel > 0 && additionalTank > 0) {
        int extraFuel = additionalTank > 0 ? additionalTank : 0;
        maxDistance += (extraFuel + usableFuel) / 5 * 5;
        totalDistance += maxDistance;
    }

    return totalDistance;
}