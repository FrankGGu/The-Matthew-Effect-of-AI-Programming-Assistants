package main

import "math"

func arrayNesting(nums []int) int {
    n := len(nums)
    maxLength := 0

    for i := 0; i < n; i++ {
        if nums[i] != -1 { 
            currentLength := 0
            startNode := i

            for nums[startNode] != -1 { 
                nextVal := nums[startNode] 
                nums[startNode] = -1      
                currentLength++
                startNode = nextVal       
            }
            maxLength = int(math.Max(float64(maxLength), float64(currentLength)))
        }
    }

    return maxLength
}