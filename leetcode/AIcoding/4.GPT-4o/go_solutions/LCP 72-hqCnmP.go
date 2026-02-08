func canCompleteCircuit(gas []int, cost []int) int {
    totalGas, totalCost, currentGas, start := 0, 0, 0, 0

    for i := 0; i < len(gas); i++ {
        totalGas += gas[i]
        totalCost += cost[i]
        currentGas += gas[i] - cost[i]

        if currentGas < 0 {
            start = i + 1
            currentGas = 0
        }
    }

    if totalGas < totalCost {
        return -1
    }

    return start
}