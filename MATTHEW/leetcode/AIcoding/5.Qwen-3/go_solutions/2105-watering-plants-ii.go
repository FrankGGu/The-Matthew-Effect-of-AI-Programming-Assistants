package main

func wateringPlants(a []int, k int) int {
    n := len(a)
    steps := 0
    currentWater := 0
    for i := 0; i < n; i++ {
        if currentWater < a[i] {
            steps += 2 * i
            currentWater = k
        }
        steps += 1
        currentWater -= a[i]
    }
    return steps
}