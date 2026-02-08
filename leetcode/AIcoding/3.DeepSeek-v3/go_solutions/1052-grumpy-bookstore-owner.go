func maxSatisfied(customers []int, grumpy []int, X int) int {
    n := len(customers)
    total := 0
    for i := 0; i < n; i++ {
        if grumpy[i] == 0 {
            total += customers[i]
        }
    }

    maxIncrease := 0
    currentIncrease := 0
    for i := 0; i < X; i++ {
        if grumpy[i] == 1 {
            currentIncrease += customers[i]
        }
    }
    maxIncrease = currentIncrease

    for i := X; i < n; i++ {
        if grumpy[i-X] == 1 {
            currentIncrease -= customers[i-X]
        }
        if grumpy[i] == 1 {
            currentIncrease += customers[i]
        }
        if currentIncrease > maxIncrease {
            maxIncrease = currentIncrease
        }
    }

    return total + maxIncrease
}