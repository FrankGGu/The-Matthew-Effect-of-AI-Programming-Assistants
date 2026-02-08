func minimumArrayLength(nums []int) int {
    minVal := nums[0]
    for _, num := range nums {
        if num < minVal {
            minVal = num
        }
    }

    count := 0
    for _, num := range nums {
        if num == minVal {
            count++
        }
    }

    for _, num := range nums {
        if num % minVal != 0 {
            return 1
        }
    }

    return (count + 1) / 2
}