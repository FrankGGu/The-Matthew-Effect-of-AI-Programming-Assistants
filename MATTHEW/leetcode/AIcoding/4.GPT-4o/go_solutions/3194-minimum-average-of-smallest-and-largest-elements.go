func minimumAverage(nums []int) float64 {
    n := len(nums)
    if n == 0 {
        return 0
    }
    minElem, maxElem := nums[0], nums[0]
    for _, num := range nums {
        if num < minElem {
            minElem = num
        }
        if num > maxElem {
            maxElem = num
        }
    }
    return float64(minElem+maxElem) / 2.0
}