func canFormArray(arr []int, pieces [][]int) bool {
    m := make(map[int][]int)
    for _, p := range pieces {
        m[p[0]] = p
    }

    i := 0
    for i < len(arr) {
        p, ok := m[arr[i]]
        if !ok {
            return false
        }

        for j := 0; j < len(p); j++ {
            if i >= len(arr) || arr[i] != p[j] {
                return false
            }
            i++
        }
    }

    return true
}