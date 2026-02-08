func shortestSeq(big []int, small []int) []int {
    smallCount := make(map[int]int)
    for _, num := range small {
        smallCount[num]++
    }
    required := len(smallCount)
    formed := 0
    windowCount := make(map[int]int)
    left, right := 0, 0
    minLen := -1
    result := []int{}

    for right < len(big) {
        num := big[right]
        windowCount[num]++
        if cnt, exists := smallCount[num]; exists && windowCount[num] == cnt {
            formed++
        }

        for formed == required && left <= right {
            currentLen := right - left + 1
            if minLen == -1 || currentLen < minLen {
                minLen = currentLen
                result = []int{left, right}
            }
            leftNum := big[left]
            windowCount[leftNum]--
            if cnt, exists := smallCount[leftNum]; exists && windowCount[leftNum] < cnt {
                formed--
            }
            left++
        }
        right++
    }

    return result
}