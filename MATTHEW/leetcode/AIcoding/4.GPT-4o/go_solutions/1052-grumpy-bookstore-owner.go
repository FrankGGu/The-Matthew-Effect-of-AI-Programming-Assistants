func maxSatisfied(customers []int, grumpy []int, X int) int {
    totalSatisfied := 0
    extraSatisfied := 0
    n := len(customers)

    for i := 0; i < n; i++ {
        if grumpy[i] == 0 {
            totalSatisfied += customers[i]
        }
    }

    for i := 0; i < X; i++ {
        if grumpy[i] == 1 {
            extraSatisfied += customers[i]
        }
    }

    maxExtra := extraSatisfied

    for i := X; i < n; i++ {
        if grumpy[i] == 1 {
            extraSatisfied += customers[i]
        }
        if grumpy[i-X] == 1 {
            extraSatisfied -= customers[i-X]
        }
        if extraSatisfied > maxExtra {
            maxExtra = extraSatisfied
        }
    }

    return totalSatisfied + maxExtra
}