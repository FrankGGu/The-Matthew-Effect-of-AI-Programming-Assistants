func minimumAbsDifference(arr []int) [][]int {
    sort.Ints(arr)
    minDiff := math.MaxInt32
    result := [][]int{}

    for i := 1; i < len(arr); i++ {
        diff := arr[i] - arr[i-1]
        if diff < minDiff {
            minDiff = diff
            result = [][]int{{arr[i-1], arr[i]}}
        } else if diff == minDiff {
            result = append(result, []int{arr[i-1], arr[i]})
        }
    }

    return result
}