func maximumSum(nums []int) int {
    freq := make(map[int]int)
    sum := make(map[int]int)
    maxNum := -1 << 31

    for _, num := range nums {
        freq[num]++
        sum[num] += num
        if num > maxNum {
            maxNum = num
        }
    }

    maxSum := -1 << 31
    for num := range freq {
        currentSum := 0
        for candidate := range freq {
            if candidate != num {
                currentSum += sum[candidate]
            }
        }
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }

    return maxSum
}