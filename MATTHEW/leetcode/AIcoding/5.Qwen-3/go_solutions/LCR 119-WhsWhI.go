package main

func longestConsecutive(nums []int) int {
    numSet := make(map[int]bool)
    for _, num := range nums {
        numSet[num] = true
    }

    longestLength := 0

    for _, num := range nums {
        if !numSet[num-1] {
            currentNum := num
            currentLength := 1

            for numSet[currentNum+1] {
                currentNum++
                currentLength++
            }

            longestLength = max(longestLength, currentLength)
        }
    }

    return longestLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}