func maxKDivisibleComponents(nums []int, k int) int {
    count := 0
    for _, num := range nums {
        if num % k == 0 {
            count++
        }
    }
    return count
}