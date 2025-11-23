package main

func rearrangeArray(nums []int, sign int) []int {
    positive := make([]int, 0)
    negative := make([]int, 0)
    for _, num := range nums {
        if num > 0 {
            positive = append(positive, num)
        } else {
            negative = append(negative, num)
        }
    }
    result := make([]int, 0)
    for i := 0; i < len(positive); i++ {
        if sign == 1 {
            result = append(result, positive[i], negative[i])
        } else {
            result = append(result, negative[i], positive[i])
        }
    }
    return result
}