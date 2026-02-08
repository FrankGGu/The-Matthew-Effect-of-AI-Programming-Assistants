package main

func mostFrequent(nums []int, key int) int {
    count := make(map[int]int)
    var maxFreq int
    var result int

    for i := 0; i < len(nums)-1; i++ {
        if nums[i] == key {
            nextNum := nums[i+1]
            count[nextNum]++
            if count[nextNum] > maxFreq {
                maxFreq = count[nextNum]
                result = nextNum
            }
        }
    }

    return result
}