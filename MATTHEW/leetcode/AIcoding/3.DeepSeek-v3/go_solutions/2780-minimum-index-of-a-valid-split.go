func minimumIndex(nums []int) int {
    dominant := -1
    count := 0
    for _, num := range nums {
        if count == 0 {
            dominant = num
            count = 1
        } else if num == dominant {
            count++
        } else {
            count--
        }
    }

    total := 0
    for _, num := range nums {
        if num == dominant {
            total++
        }
    }

    left := 0
    for i := 0; i < len(nums)-1; i++ {
        if nums[i] == dominant {
            left++
        }
        right := total - left
        if left * 2 > i+1 && right * 2 > len(nums)-i-1 {
            return i
        }
    }

    return -1
}