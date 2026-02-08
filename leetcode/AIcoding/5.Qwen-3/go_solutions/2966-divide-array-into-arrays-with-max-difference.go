package main

func divideArray(nums []int, k int) [][]int {
    sort.Ints(nums)
    result := make([][]int, 0)
    for i := 0; i < len(nums); i += 3 {
        result = append(result, nums[i:i+3])
    }
    return result
}