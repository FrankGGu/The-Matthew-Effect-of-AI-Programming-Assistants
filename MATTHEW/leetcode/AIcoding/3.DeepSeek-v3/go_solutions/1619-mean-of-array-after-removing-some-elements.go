import "sort"

func trimMean(arr []int) float64 {
    sort.Ints(arr)
    n := len(arr)
    sum := 0
    for i := n / 20; i < n - n / 20; i++ {
        sum += arr[i]
    }
    return float64(sum) / float64(n * 9 / 10)
}