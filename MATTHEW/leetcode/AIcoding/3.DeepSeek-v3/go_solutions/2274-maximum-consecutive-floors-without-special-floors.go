import "sort"

func maxConsecutive(bottom int, top int, special []int) int {
    sort.Ints(special)
    max := special[0] - bottom
    for i := 1; i < len(special); i++ {
        diff := special[i] - special[i-1] - 1
        if diff > max {
            max = diff
        }
    }
    lastDiff := top - special[len(special)-1]
    if lastDiff > max {
        max = lastDiff
    }
    return max
}