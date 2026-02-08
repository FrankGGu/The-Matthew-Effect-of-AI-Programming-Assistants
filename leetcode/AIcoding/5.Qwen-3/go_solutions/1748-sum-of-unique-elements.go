package main

func sumOfUniqueElements(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }
    sum := 0
    for num, freq := range count {
        if freq == 1 {
            sum += num
        }
    }
    return sum
}