function distanceTraveled(mainTank, additionalTank) {
    let totalDistance = 0;
    const maxDistance = mainTank * 5;

    if (mainTank <= 0) return 0;

    totalDistance += Math.min(maxDistance, (mainTank + additionalTank) * 5);
    return totalDistance;
}