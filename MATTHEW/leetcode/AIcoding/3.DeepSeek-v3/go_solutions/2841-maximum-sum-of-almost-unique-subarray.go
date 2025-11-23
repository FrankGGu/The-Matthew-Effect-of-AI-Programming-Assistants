func maxSum(nums []int, m int, k int) int64 {
    freq := make(map[int]int)
    distinct := 0
    maxSum := int64(0)
    currentSum := int64(0)

    for i := 0; i < len(nums); i++ {
        num := nums[i]
        if freq[num] == 0 {
            distinct++
        }
        freq[num]++
        currentSum += int64(num)

        if i >= k {
            left := nums[i-k]
            freq[left]--
            if freq[left] == 0 {
                distinct--
            }
            currentSum -= int64(left)
        }

        if i >= k-1 && distinct >= m {
            if currentSum > maxSum {
                maxSum = currentSum
            }
        }
    }

    return maxSum
}