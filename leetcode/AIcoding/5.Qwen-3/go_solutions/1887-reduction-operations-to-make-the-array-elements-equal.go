package main

func reductionOperations(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    sorted := make([]int, 0, len(count))
    for key := range count {
        sorted = append(sorted, key)
    }
    sort.Ints(sorted)

    res := 0
    for i := len(sorted) - 1; i > 0; i-- {
        res += count[sorted[i]] * (i)
    }

    return res
}