package main


func numberOfWeeks(i []int) int {
    sort.Ints(i)
    res := 0
    for i > 0 {
        res += i % 10
        i /= 10
    }
    return res
}