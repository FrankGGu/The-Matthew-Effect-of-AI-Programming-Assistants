func minOperations(target []int, arr []int) int {
    pos := make(map[int]int)
    for i, v := range target {
        pos[v] = i
    }

    var sub []int
    for _, v := range arr {
        if _, ok := pos[v]; ok {
            idx := pos[v]
            if len(sub) == 0 || idx > sub[len(sub)-1] {
                sub = append(sub, idx)
            } else {
                l, r := 0, len(sub)-1
                for l < r {
                    mid := (l + r) / 2
                    if sub[mid] < idx {
                        l = mid + 1
                    } else {
                        r = mid
                    }
                }
                sub[l] = idx
            }
        }
    }

    return len(target) - len(sub)
}