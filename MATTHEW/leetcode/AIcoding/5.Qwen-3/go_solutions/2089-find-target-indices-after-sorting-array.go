package main

func targetIndices(nums []int, target int) []int {
    sort.Ints(nums)
    result := make([]int, 0)
    for i, num := range nums {
        if num == target {
            result = append(result, i)
        }
    }
    return result
}