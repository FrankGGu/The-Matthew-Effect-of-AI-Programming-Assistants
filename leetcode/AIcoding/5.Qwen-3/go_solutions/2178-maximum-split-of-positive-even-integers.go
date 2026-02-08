package main

func maximumEvenSplit(num int) []int {
    if num%2 != 0 {
        return []int{}
    }
    result := make([]int, 0)
    for i := 2; i <= num; i += 2 {
        result = append(result, i)
        num -= i
    }
    return result
}