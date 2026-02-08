func findInteger(arr []int, target int) int {
    sum := 0
    for _, num := range arr {
        sum += num
    }
    return target - sum
}