func findSmallestInteger(nums []int, value int) int {
    count := make([]int, value)
    for _, num := range nums {
        mod := (num % value + value) % value
        count[mod]++
    }

    minCount := -1
    res := 0
    for i := 0; i < value; i++ {
        if minCount == -1 || count[i] < minCount {
            minCount = count[i]
            res = i
        }
    }

    return minCount * value + res
}