func findErrorNums(nums []int) []int {
    n := len(nums)
    count := make([]int, n+1)
    for _, num := range nums {
        count[num]++
    }
    missing, duplicate := 0, 0
    for i := 1; i <= n; i++ {
        if count[i] == 0 {
            missing = i
        } else if count[i] == 2 {
            duplicate = i
        }
    }
    return []int{duplicate, missing}
}