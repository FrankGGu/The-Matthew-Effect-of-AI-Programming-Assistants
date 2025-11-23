func smallerNumbersThanCurrent(nums []int) []int {
    count := make([]int, 101)
    for _, num := range nums {
        count[num]++
    }
    for i := 1; i < 101; i++ {
        count[i] += count[i-1]
    }
    res := make([]int, len(nums))
    for i, num := range nums {
        if num == 0 {
            res[i] = 0
        } else {
            res[i] = count[num-1]
        }
    }
    return res
}