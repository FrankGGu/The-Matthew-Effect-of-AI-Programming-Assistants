package main

func closestEqual(nums []int, queries []int) []int {
    n := len(nums)
    result := make([]int, len(queries))

    for i := range queries {
        q := queries[i]
        minDist := -1
        closestVal := -1

        for j := 0; j < n; j++ {
            if nums[j] == nums[q] {
                dist := abs(j - q)
                if minDist == -1 || dist < minDist {
                    minDist = dist
                    closestVal = nums[j]
                }
            }
        }

        result[i] = closestVal
    }

    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}