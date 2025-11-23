package main

func mostFrequentEven(nums []int) int {
    count := make(map[int]int)
    maxFreq := 0
    result := -1

    for _, num := range nums {
        if num%2 == 0 {
            count[num]++
            if count[num] > maxFreq || (count[num] == maxFreq && num < result) {
                maxFreq = count[num]
                result = num
            }
        }
    }

    return result
}