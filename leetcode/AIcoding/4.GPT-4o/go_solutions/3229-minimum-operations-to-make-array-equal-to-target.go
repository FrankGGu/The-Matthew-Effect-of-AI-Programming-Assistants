func minOperations(n int, target int) int {
    sum := n * (n - 1) / 2
    if sum == target {
        return 0
    }
    if sum < target {
        return target - sum
    }
    return sum - target
}