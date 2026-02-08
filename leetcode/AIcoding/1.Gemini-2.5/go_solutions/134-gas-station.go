func canCompleteCircuit(gas []int, cost []int) int {
    totalGas := 0
    totalCost := 0
    currentTank := 0
    startStation := 0

    for i := 0; i < len(gas); i++ {
        totalGas += gas[i]
        totalCost += cost[i]
        currentTank += gas[i] - cost[i]

        if currentTank < 0 {
            startStation = i + 1
            currentTank = 0
        }
    }

    if totalGas < totalCost {
        return -1
    } else {
        return startStation
    }
}