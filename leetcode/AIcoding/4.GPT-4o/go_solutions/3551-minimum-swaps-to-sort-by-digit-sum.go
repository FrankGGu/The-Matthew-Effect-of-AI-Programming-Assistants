func minSwaps(nums []int) int {
    n := len(nums)
    type pair struct {
        value int
        index int
    }

    arr := make([]pair, n)
    for i := 0; i < n; i++ {
        arr[i] = pair{value: nums[i], index: i}
    }

    sort.Slice(arr, func(i, j int) bool {
        return arr[i].value < arr[j].value
    })

    visited := make([]bool, n)
    swaps := 0

    for i := 0; i < n; i++ {
        if visited[i] || arr[i].index == i {
            continue
        }

        cycleSize := 0
        j := i

        for !visited[j] {
            visited[j] = true
            j = arr[j].index
            cycleSize++
        }

        if cycleSize > 0 {
            swaps += cycleSize - 1
        }
    }

    return swaps
}