func longestSubarray(arr []int) int {
    maxVal := 0
    for _, num := range arr {
        if num > maxVal {
            maxVal = num
        }
    }

    maxLength := 0
    currentLength := 0

    for _, num := range arr {
        if num == maxVal {
            currentLength++
            if currentLength > maxLength {
                maxLength = currentLength
            }
        } else {
            currentLength = 0
        }
    }

    return maxLength
}