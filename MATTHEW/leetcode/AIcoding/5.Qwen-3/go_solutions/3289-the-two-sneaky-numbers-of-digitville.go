package main

func twoSneakyNumbers(arr []int) []int {
    count := make(map[int]int)
    result := []int{}
    for _, num := range arr {
        count[num]++
        if count[num] == 2 {
            result = append(result, num)
        }
    }
    return result
}