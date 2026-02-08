func minNumberOperations(target []int) int {
    if len(target) == 0 {
        return 0
    }

    operations := target[0]

    for i := 1; i < len(target); i++ {
        if target[i] > target[i-1] {
            operations += target[i] - target[i-1]
        }
    }

    return operations
}