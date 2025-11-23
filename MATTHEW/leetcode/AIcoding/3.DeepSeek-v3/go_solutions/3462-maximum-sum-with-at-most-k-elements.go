func maximizeSum(nums []int, k int) int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }
    return maxNum*k + k*(k-1)/2
}