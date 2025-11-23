func maxNumOfSubstrings(s string) []string {
    first := make([]int, 26)
    last := make([]int, 26)
    for i := range first {
        first[i] = -1
        last[i] = -1
    }
    for i, ch := range s {
        idx := int(ch - 'a')
        if first[idx] == -1 {
            first[idx] = i
        }
        last[idx] = i
    }

    intervals := make([][]int, 0)
    for i := 0; i < 26; i++ {
        if first[i] == -1 {
            continue
        }
        left := first[i]
        right := last[i]
        valid := true
        for j := left; j <= right; j++ {
            idx := int(s[j] - 'a')
            if first[idx] < left {
                valid = false
                break
            }
            if last[idx] > right {
                right = last[idx]
            }
        }
        if valid {
            intervals = append(intervals, []int{left, right})
        }
    }

    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][1] < intervals[j][1]
    })

    res := make([]string, 0)
    prevEnd := -1
    for _, interval := range intervals {
        if interval[0] > prevEnd {
            res = append(res, s[interval[0]:interval[1]+1])
            prevEnd = interval[1]
        }
    }

    return res
}