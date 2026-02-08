package main

func eliminateMaximum(target []int, arr []int) int {
    n := len(target)
    time := make([]float64, n)
    for i := 0; i < n; i++ {
        time[i] = float64(target[i]) / float64(arr[i])
    }
    sort.Float64s(time)
    for i := 0; i < n; i++ {
        if float64(i) >= time[i] {
            return i
        }
    }
    return n
}