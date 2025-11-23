package main

func sortEvenOdd(nums []int) []int {
    even := make([]int, 0)
    odd := make([]int, 0)
    for i, num := range nums {
        if i%2 == 0 {
            even = append(even, num)
        } else {
            odd = append(odd, num)
        }
    }
    sort.Ints(even)
    sort.Ints(odd)
    res := make([]int, len(nums))
    e, o := 0, 0
    for i := 0; i < len(nums); i++ {
        if i%2 == 0 {
            res[i] = even[e]
            e++
        } else {
            res[i] = odd[o]
            o++
        }
    }
    return res
}