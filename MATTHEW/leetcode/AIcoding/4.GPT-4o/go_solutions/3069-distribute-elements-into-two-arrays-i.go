func distributeArray(nums []int) []int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    result := make([]int, len(nums))
    idx := 0
    for num, cnt := range count {
        for cnt > 0 {
            result[idx] = num
            idx++
            cnt--
            if idx >= len(nums) {
                break
            }
        }
    }

    return result
}