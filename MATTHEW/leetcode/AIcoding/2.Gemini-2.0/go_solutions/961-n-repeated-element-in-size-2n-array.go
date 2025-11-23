func repeatedNTimes(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
        if count[num] > 1 {
            return num
        }
    }
    return 0
}