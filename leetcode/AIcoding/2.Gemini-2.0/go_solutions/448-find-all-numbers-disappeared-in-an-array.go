func findDisappearedNumbers(nums []int) []int {
    n := len(nums)
    for _, num := range nums {
        num = abs(num)
        if nums[num-1] > 0 {
            nums[num-1] *= -1
        }
    }

    result := []int{}
    for i := 0; i < n; i++ {
        if nums[i] > 0 {
            result = append(result, i+1)
        }
    }

    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}