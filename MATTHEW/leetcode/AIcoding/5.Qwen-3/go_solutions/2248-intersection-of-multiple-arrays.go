package main

func intersection(nums [][]int) []int {
    count := make(map[int]int)
    for _, arr := range nums {
        seen := make(map[int]bool)
        for _, num := range arr {
            if !seen[num] {
                seen[num] = true
                count[num]++
            }
        }
    }
    result := []int{}
    for num, c := range count {
        if c == len(nums) {
            result = append(result, num)
        }
    }
    return result
}