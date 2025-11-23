func canBeMadeEmpty(nums []int) bool {
    sum := 0
    for _, num := range nums {
        sum += num
    }
    return sum%2 == 0
}