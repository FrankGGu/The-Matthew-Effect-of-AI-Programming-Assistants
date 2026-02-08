func smallerNumbersThanCurrent(nums []int) []int {
    count := make([]int, 101)
    result := make([]int, len(nums))

    for _, num := range nums {
        count[num]++
    }

    for i := 1; i < len(count); i++ {
        count[i] += count[i-1]
    }

    for i, num := range nums {
        if num > 0 {
            result[i] = count[num-1]
        }
    }

    return result
}