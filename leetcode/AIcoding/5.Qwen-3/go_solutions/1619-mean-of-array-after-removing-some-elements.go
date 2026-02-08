package main

func meanAfterRemoveElements(arr []int) float64 {
    n := len(arr)
    if n == 0 {
        return 0.0
    }
    sort.Ints(arr)
    remove := n / 5
    sum := 0
    for i := remove; i < n - remove; i++ {
        sum += arr[i]
    }
    return float64(sum) / float64(n - 2*remove)
}