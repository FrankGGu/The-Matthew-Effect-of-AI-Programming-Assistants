func findErrorNums(nums []int) []int {
    n := len(nums)
    count := make([]int, n+1)
    for _, num := range nums {
        count[num]++
    }
    res := make([]int, 2)
    for i := 1; i <= n; i++ {
        if count[i] == 2 {
            res[0] = i
        } else if count[i] == 0 {
            res[1] = i
        }
    }
    return res
}