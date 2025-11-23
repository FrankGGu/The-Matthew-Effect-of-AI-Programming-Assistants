func longestEvenOddSubarray(nums []int, threshold int) int {
    maxLength := 0
    currentLength := 0

    for _, num := range nums {
        if num > threshold {
            currentLength = 0
        } else {
            if currentLength == 0 || (num%2) != (nums[currentLength-1]%2) {
                currentLength++
            } else {
                currentLength = 1
            }
            maxLength = max(maxLength, currentLength)
        }
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}