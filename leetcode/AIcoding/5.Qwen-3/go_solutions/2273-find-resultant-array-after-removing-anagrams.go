package main

func removeAnagrams(nums []int) []int {
    result := make([]int, 0)
    prev := -1
    for _, num := range nums {
        if prev == -1 {
            result = append(result, num)
            prev = num
        } else {
            sumPrev := 0
            temp := prev
            for temp > 0 {
                sumPrev += temp % 10
                temp /= 10
            }
            sumCurr := 0
            temp = num
            for temp > 0 {
                sumCurr += temp % 10
                temp /= 10
            }
            if sumPrev != sumCurr {
                result = append(result, num)
                prev = num
            }
        }
    }
    return result
}