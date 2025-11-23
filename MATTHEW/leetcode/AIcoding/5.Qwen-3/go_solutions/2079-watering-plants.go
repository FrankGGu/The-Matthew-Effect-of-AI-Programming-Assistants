package main

func wateringPlants(plant []int, capacity int) int {
    steps := 0
    currentCapacity := capacity
    for i := 0; i < len(plant); i++ {
        if currentCapacity < plant[i] {
            steps += 2 * i
            currentCapacity = capacity
        }
        steps++
        currentCapacity -= plant[i]
    }
    return steps
}