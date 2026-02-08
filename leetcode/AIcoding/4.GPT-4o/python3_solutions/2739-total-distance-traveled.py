def distanceTraveled(self, mainTank: int, additionalTank: int) -> int:
    total_distance = 0
    if mainTank <= 0:
        return total_distance

    max_distance = min(mainTank, 5)
    total_distance += max_distance * 10
    mainTank -= max_distance

    if mainTank > 0:
        additional_used = min(mainTank, additionalTank)
        total_distance += additional_used * 10
        mainTank -= additional_used

    return total_distance