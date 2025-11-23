func minimumAverage(nums []int) float64 {
    minNum := nums[0]
    maxNum := nums[0]

    for _, num := range nums {
        if num < minNum {
            minNum = num
        }
        if num > maxNum {
            maxNum = num
        }
    }

    return float64(minNum + maxNum) / 2.0
}