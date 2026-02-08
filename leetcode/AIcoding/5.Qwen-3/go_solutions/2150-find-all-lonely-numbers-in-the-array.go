package main

func findLonely(nums []int) []int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    result := make([]int, 0)
    for _, num := range nums {
        if count[num] == 1 && count[num-1] == 0 && count[num+1] == 0 {
            result = append(result, num)
        }
    }

    return result
}