func makeSubKSumEqual(arr []int, k int) int64 {
    n := len(arr)
    visited := make([]bool, n)
    res := int64(0)

    for i := 0; i < n; i++ {
        if visited[i] {
            continue
        }
        group := []int{}
        j := i
        for !visited[j] {
            visited[j] = true
            group = append(group, arr[j])
            j = (j + k) % n
        }
        sort.Ints(group)
        median := group[len(group)/2]
        for _, num := range group {
            res += int64(abs(num - median))
        }
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}