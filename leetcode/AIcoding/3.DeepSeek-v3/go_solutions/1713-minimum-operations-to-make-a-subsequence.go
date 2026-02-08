func minOperations(target []int, arr []int) int {
    pos := make(map[int]int)
    for i, num := range target {
        pos[num] = i
    }

    var lis []int
    for _, num := range arr {
        if idx, ok := pos[num]; ok {
            if len(lis) == 0 || idx > lis[len(lis)-1] {
                lis = append(lis, idx)
            } else {
                l, r := 0, len(lis)-1
                for l < r {
                    mid := (l + r) / 2
                    if lis[mid] < idx {
                        l = mid + 1
                    } else {
                        r = mid
                    }
                }
                lis[l] = idx
            }
        }
    }
    return len(target) - len(lis)
}