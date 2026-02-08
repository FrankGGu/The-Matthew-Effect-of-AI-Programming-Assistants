package main

func maximumHappinessSum(happiness []int, k int) int {
    sort.Sort(sort.Reverse(sort.IntSlice(happiness)))
    res := 0
    for i := 0; i < k; i++ {
        if happiness[i]-i > 0 {
            res += happiness[i] - i
        }
    }
    return res
}