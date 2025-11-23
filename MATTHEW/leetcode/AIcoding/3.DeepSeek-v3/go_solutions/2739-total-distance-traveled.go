func distanceTraveled(mainTank int, additionalTank int) int {
    distance := 0
    for mainTank >= 5 {
        used := mainTank / 5 * 5
        distance += used * 10
        mainTank %= 5
        transfer := min(additionalTank, used / 5)
        mainTank += transfer
        additionalTank -= transfer
    }
    distance += mainTank * 10
    return distance
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}