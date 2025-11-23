package main

func minimizeXOR(nums []int, queries []int) []int {
    result := make([]int, len(queries))
    for i := range queries {
        target := queries[i]
        minDiff := int(^uint(0) >> 1)
        bestNum := 0
        for _, num := range nums {
            diff := num ^ target
            if diff < minDiff {
                minDiff = diff
                bestNum = num
            }
        }
        result[i] = bestNum
    }
    return result
}