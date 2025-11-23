package main

func findLargestAlmostMissingInteger(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    var candidates []int
    for num := range count {
        candidates = append(candidates, num)
    }

    sort.Ints(candidates)

    for i := len(candidates) - 1; i >= 0; i-- {
        if count[candidates[i]] == 1 {
            return candidates[i]
        }
    }

    return -1
}