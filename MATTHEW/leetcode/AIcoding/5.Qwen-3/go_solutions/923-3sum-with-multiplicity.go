package main

func fourSumCount(A []int, B []int, C []int, D []int) int {
    count := make(map[int]int)
    for _, a := range A {
        for _, b := range B {
            count[a+b]++
        }
    }
    result := 0
    for _, c := range C {
        for _, d := range D {
            target := -(c + d)
            result += count[target]
        }
    }
    return result
}