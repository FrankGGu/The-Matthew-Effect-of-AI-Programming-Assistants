func canChoose(groups [][]int, nums []int) bool {
    groupIdx := 0
    numIdx := 0

    for groupIdx < len(groups) {
        currentGroup := groups[groupIdx]

        foundMatch := false
        matchEnd := -1

        // Iterate through possible starting positions in nums for currentGroup
        // The loop condition ensures there are enough elements remaining in nums
        for i := numIdx; i <= len(nums)-len(currentGroup); i++ {
            isMatch := true
            for k := 0; k < len(currentGroup); k++ {
                if nums[i+k] != currentGroup[k] {
                    isMatch = false
                    break
                }
            }
            if isMatch {
                foundMatch = true
                matchEnd = i + len(currentGroup)
                break // Found the first match for currentGroup, move to the next group
            }
        }

        if !foundMatch {
            return false // Current group not found in the remaining part of nums
        }

        groupIdx++
        numIdx = matchEnd // Start searching for the next group from the end of the current match
    }

    return true // All groups were successfully found and concatenated
}