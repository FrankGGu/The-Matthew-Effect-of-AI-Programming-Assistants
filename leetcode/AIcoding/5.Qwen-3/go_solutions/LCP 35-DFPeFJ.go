package main

func canCompleteCircuit(gas []int, cost []int) int {
    n := len(gas)
    total := 0
    current := 0
    start := 0

    for i := 0; i < n; i++ {
        total += gas[i] - cost[i]
        current += gas[i] - cost[i]
        if current < 0 {
            start = i + 1
            current = 0
        }
    }

    if total < 0 {
        return -1
    }

    return start
}