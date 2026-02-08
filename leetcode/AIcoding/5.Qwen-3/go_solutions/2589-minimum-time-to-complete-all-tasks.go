package main

func mostFrequentEven(nums []int) int {
    count := make(map[int]int)
    maxFreq := 0
    result := -1

    for _, num := range nums {
        if num%2 == 0 {
            count[num]++
            if count[num] > maxFreq {
                maxFreq = count[num]
                result = num
            } else if count[num] == maxFreq && num < result {
                result = num
            }
        }
    }

    return result
}