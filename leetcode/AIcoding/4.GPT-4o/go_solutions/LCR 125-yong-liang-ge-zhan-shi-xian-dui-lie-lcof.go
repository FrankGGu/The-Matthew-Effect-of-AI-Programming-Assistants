func minOperations(nums []int) int {
    n := len(nums)
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    res := 0
    for _, num := range nums {
        if count[num] > 0 {
            res++
            count[num]--
            for i := 1; i <= n; i++ {
                count[num+i]--
            }
        }
    }

    return res
}