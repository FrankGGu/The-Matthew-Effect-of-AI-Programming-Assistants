func countSubarrays(nums []int) int64 {
    left := 0
    res := 0
    minDeque := []int{}
    maxDeque := []int{}

    for right := 0; right < len(nums); right++ {
        for len(minDeque) > 0 && nums[right] < nums[minDeque[len(minDeque)-1]] {
            minDeque = minDeque[:len(minDeque)-1]
        }
        minDeque = append(minDeque, right)

        for len(maxDeque) > 0 && nums[right] > nums[maxDeque[len(maxDeque)-1]] {
            maxDeque = maxDeque[:len(maxDeque)-1]
        }
        maxDeque = append(maxDeque, right)

        for nums[maxDeque[0]] - nums[minDeque[0]] > 2 {
            left++
            if minDeque[0] < left {
                minDeque = minDeque[1:]
            }
            if maxDeque[0] < left {
                maxDeque = maxDeque[1:]
            }
        }

        res += right - left + 1
    }

    return int64(res)
}