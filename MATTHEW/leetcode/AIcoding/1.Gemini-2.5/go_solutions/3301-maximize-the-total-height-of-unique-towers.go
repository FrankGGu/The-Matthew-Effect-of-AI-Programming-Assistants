package main

import "fmt"

func maximizeBuildingHeight(maxHeights []int) int64 {
    n := len(maxHeights)

    prefix := make([]int64, n)
    stack := []int{} // Stores indices

    for i := 0; i < n; i++ {
        h_i := int64(maxHeights[i])
        for len(stack) > 0 && int64(maxHeights[stack[len(stack)-1]]) >= h_i {
            stack = stack[:len(stack)-1] // Pop
        }

        var prevIdx int
        if len(stack) > 0 {
            prevIdx = stack[len(stack)-1]
        } else {
            prevIdx = -1 // Sentinel for start of array
        }

        // Calculate sum for current segment [prevIdx+1, i]
        // All towers in this segment will have height h_i
        currentSegmentSum := h_i * int64(i - prevIdx)

        // Add sum from previous segment (if any)
        if prevIdx != -1 {
            prefix[i] = currentSegmentSum + prefix[prevIdx]
        } else {
            prefix[i] = currentSegmentSum
        }

        stack = append(stack, i)
    }

    suffix := make([]int64, n)
    stack = []int{} // Reset stack

    for i := n - 1; i >= 0; i-- {
        h_i := int64(maxHeights[i])
        for len(stack) > 0 && int64(maxHeights[stack[len(stack)-1]]) >= h_i {
            stack = stack[:len(stack)-1] // Pop
        }

        var nextIdx int
        if len(stack) > 0 {
            nextIdx = stack[len(stack)-1]
        } else {
            nextIdx = n // Sentinel for end of array
        }

        // Calculate sum for current segment [i, nextIdx-1]
        // All towers in this segment will have height h_i
        currentSegmentSum := h_i * int64(nextIdx - i)

        // Add sum from next segment (if any)
        if nextIdx != n {
            suffix[i] = currentSegmentSum + suffix[nextIdx]
        } else {
            suffix[i] = currentSegmentSum
        }

        stack = append(stack, i)
    }

    var maxTotalHeight int64 = 0
    for i := 0; i < n; i++ {
        // The height maxHeights[i] is counted in both prefix[i] and suffix[i], so subtract it once.
        totalHeight := prefix[i] + suffix[i] - int64(maxHeights[i])
        if totalHeight > maxTotalHeight {
            maxTotalHeight = totalHeight
        }
    }

    return maxTotalHeight
}